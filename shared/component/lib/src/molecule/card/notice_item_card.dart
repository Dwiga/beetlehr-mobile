import 'package:flutter/material.dart';

class NoticeItemCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback? onTap;
  const NoticeItemCard({
    Key? key,
    required this.title,
    required this.date,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(date),
      trailing: const Icon(Icons.chevron_right_outlined),
    );
  }
}
