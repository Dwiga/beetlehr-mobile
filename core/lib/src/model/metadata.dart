import '../../core.dart';

/// Base meta when receive data from a API
class MetaData {
  /// Message base from data API, message success or message failure
  final String? message;

  /// When success is true, otherwise false
  final bool success;

  /// Pagination data
  final Pagination? pagination;

  ///
  MetaData({
    required this.message,
    required this.success,
    this.pagination,
  });

  /// Mapping data [MetaData] from Map or Json data
  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      message: json['message'] ?? _listErrorToMessage(json['error']),
      success: json['success'],
      pagination: json['pagination'] is Map
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  static String _listErrorToMessage(dynamic errors) {
    var message = '';

    if (errors is String) {
      return errors;
    }

    if (errors != null && errors is Map) {
      for (var item in errors.values) {
        if (item is List) {
          for (var itemMessage in item) {
            message += '- $itemMessage\n';
          }
        }
      }
    }

    return (message.toString()).trim();
  }

  /// Generate [MetaData] toMap
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'pagination': pagination?.toJson(),
    };
  }
}

/// Base meta data error when receive data from a API
class ErrorMetaData {
  /// Message base from data API, message error
  final String error;

  /// When success is true, otherwise false
  final bool success;

  ///
  ErrorMetaData({
    required this.error,
    required this.success,
  });

  /// Mapping data [MetaData] from Map or Json data
  factory ErrorMetaData.fromJson(Map<String, dynamic> json) {
    return ErrorMetaData(error: json['error'], success: json['success']);
  }

  /// Generate [MetaData] toMap
  Map<String, dynamic> toJson() {
    return {
      'message': error,
      'error': success,
    };
  }
}
