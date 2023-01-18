import 'package:flutter/material.dart';
import 'package:notice/src/presentation/pages/approval_request/sections/sections.dart';

class ApprovalPage extends StatefulWidget {
  const ApprovalPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {
  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ApprovalHeaderSection(buttonColor: theme.primaryColor),
    );
  }
}
