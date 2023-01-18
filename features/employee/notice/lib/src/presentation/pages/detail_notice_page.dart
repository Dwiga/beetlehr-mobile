import 'dart:async';
import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../notice.dart';

class DetailNoticePage extends StatefulWidget {
  final NoticeEntity notice;
  const DetailNoticePage({
    Key? key,
    required this.notice,
  }) : super(key: key);
  @override
  _DetailNoticePageState createState() => _DetailNoticePageState();
}

class _DetailNoticePageState extends State<DetailNoticePage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  Future<Either<Failure, String>> _startDownloadingFile(String url) async {
    final path = await getTemporaryDirectory();
    return GetIt.I<DownloadFileUseCase>().call(
      DownloadFileParams(
        url,
        fileName: widget.notice.hashCode.toString() + '.pdf',
        savePath: path.absolute.path +
            Platform.pathSeparator +
            widget.notice.hashCode.toString() +
            '.pdf',
        withHttpClint: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.notice.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.notice.description != null &&
        widget.notice.description!.isNotEmpty) {
      return _buildHtmlView();
    }

    return _buildPDFView();
  }

  Widget _buildPDFView() {
    return FutureBuilder<Either<Failure, String>>(
      future: _startDownloadingFile(widget.notice.file!),
      builder: (context, snapshot) {
        if (snapshot.data?.isLeft() ?? false) {
          return Center(
            child: PrimaryButton(
              onPressed: () {
                setState(() {});
              },
              child: Text(S.of(context).reload),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isRight()) {
          return PDFView(
            filePath: snapshot.data!.getOrElse(() => ''),
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: false,
            onRender: (_pages) {},
            onError: (error) {},
            onPageError: (page, error) {},
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onPageChanged: (page, total) {},
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildHtmlView() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Html(
          data: widget.notice.description ?? '',
        ),
      ),
    );
  }
}
