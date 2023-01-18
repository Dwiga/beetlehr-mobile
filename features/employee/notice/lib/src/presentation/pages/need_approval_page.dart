import 'package:component/component.dart';
import 'package:flutter/material.dart';

class NeedApprovalPage extends StatefulWidget {
  const NeedApprovalPage({Key? key}) : super(key: key);

  @override
  _NeedApprovalPageState createState() => _NeedApprovalPageState();
}

class _NeedApprovalPageState extends State<NeedApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, i) {
          return NeedApprovalCard(
            count: 12,
            onTap: () {
              Navigator.pushNamed(context, '/list-need-approval');
            },
            title: 'Contoh',
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(height: 1);
        },
        itemCount: 7);
  }
}
