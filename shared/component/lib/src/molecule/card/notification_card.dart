import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class NotificationCard extends StatelessWidget {
  final bool isRead;
  final String title;
  final DateTime time;

  const NotificationCard(
      {Key? key, this.isRead = false, required this.title, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp16),
      color: !isRead ? const Color(0xffF3FAFF) : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(context, AppIcons.tasksLine, StaticColors.orange),
          const SizedBox(width: Dimens.dp24),
          Expanded(
              child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: isRead
                        ? const RegularText(
                            'Your payroll has been Paid!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SubTitle2Text(
                            'Your payroll has been Paid!',
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const RegularText(
                        '12 minutes ago',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 12),
                  children: [
                    TextSpan(text: 'Your payroll for '),
                    TextSpan(
                      text: 'March ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'has been paid. You can check your payroll slip here',
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, IconData icon, [Color? color]) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp10),
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).disabledColor,
          shape: BoxShape.circle),
      child: Icon(icon, size: Dimens.dp22, color: Colors.white),
    );
  }
}
