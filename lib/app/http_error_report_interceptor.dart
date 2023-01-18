import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dependencies/dependencies.dart';
import 'package:settings/settings.dart';

class HttpErrorReportInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.connectTimeout ||
        err.type == DioErrorType.sendTimeout ||
        err.type == DioErrorType.receiveTimeout) {
      final isConnectInternet = await InternetConnectionChecker().hasConnection;
      if (isConnectInternet) {
        _sendErrorReport(
          'WARNING!!!... SERVER TIMEOUT, ERROR CODE: ${err.response?.statusCode ?? '-'}',
          err.requestOptions,
          err.response,
        );
      }
    } else if (err.response?.statusCode != null &&
        err.response!.statusCode! >= 500) {
      _sendErrorReport(
        'URGEN!!!.... SERVER ERROR ${err.response?.statusCode}',
        err.requestOptions,
        err.response,
      );
    } else if (err.response?.statusCode != null &&
        err.response!.statusCode! >= 404) {
      String? message;
      final url = err.requestOptions.uri.toString();

      if (err.response!.statusCode! == 404) {
        message = 'WARNING!!!... URL NOT FOUND $url';
      }

      _sendErrorReport(
        message ??
            'FAILURE HIT API!!!... ${err.response?.statusMessage} ${err.response?.statusCode} on $url',
        err.requestOptions,
      );
    }

    handler.next(err);
  }

  void _sendErrorReport(String errorMessage, RequestOptions requestOptions,
      [Response? response]) async {
    final _url = requestOptions.baseUrl + requestOptions.path;

    final List<SentryAttachment> _attachments = [];

    if (requestOptions.data != null) {
      String? typeData;

      if (requestOptions.data is Map) {
        typeData = 'json';
      } else if (requestOptions.data is String) {
        typeData = 'txt';
      }

      if (typeData != null) {
        _attachments.add(
          SentryAttachment.fromUint8List(
            _encodeToUnit8List(requestOptions.data),
            'payload.$typeData',
          ),
        );
      }
    }

    if (response?.data != null) {
      String? typeData;

      if (response!.data is Map) {
        typeData = 'json';
      } else if (response.data is String) {
        typeData = 'txt';
      }

      if (typeData != null) {
        _attachments.add(
          SentryAttachment.fromUint8List(
            _encodeToUnit8List(response.data),
            'response.$typeData',
          ),
        );
      }
    }

    _attachments.add(
      SentryAttachment.fromUint8List(
        _encodeToUnit8List(requestOptions.headers),
        'headers.json',
      ),
    );

    await GetIt.I<RecordErrorUseCase>()(
      RecordErrorParams(
        exception: HttpException(errorMessage, uri: Uri.tryParse(_url)),
        stackTrace: StackTrace.fromString(
          'URL: $_url\n'
          'METHOD: ${requestOptions.method}\n',
        ),
        errorMessage: errorMessage,
        level: (response?.statusCode != null && response!.statusCode! >= 500)
            ? SentryLevel.fatal
            : SentryLevel.error,
        tags: [
          'http-error-${response?.statusCode ?? ''}',
          response?.statusCode.toString() ?? 'timeout',
          'http-client'
        ],
        attachments: _attachments,
      ),
    );
  }

  Uint8List _encodeToUnit8List(data) {
    try {
      if (data is Map || data is List) {
        return Uint8List.fromList(json.encode(data).codeUnits);
      }
      return Uint8List.fromList(data.toString().codeUnits);
    } catch (e) {
      return Uint8List.fromList(data.toString().codeUnits);
    }
  }
}
