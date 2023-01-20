import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../notice.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).approval_request),
        ),
        body: const ApprovalPage(),
      ),
    );
  }
}
