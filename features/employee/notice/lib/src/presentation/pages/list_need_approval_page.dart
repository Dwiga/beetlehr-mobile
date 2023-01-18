import 'package:component/component.dart';
import 'package:flutter/material.dart';

class ListNeedApprovalPage extends StatefulWidget {
  const ListNeedApprovalPage({Key? key}) : super(key: key);

  @override
  _ListNeedApprovalPageState createState() => _ListNeedApprovalPageState();
}

class _ListNeedApprovalPageState extends State<ListNeedApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reimbrusment'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (_, i) {
          return NotificationCard(
            isRead: true,
            time: DateTime.now(),
            title: 'Contoh',
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(height: 1);
        },
        itemCount: 17);
  }
}
