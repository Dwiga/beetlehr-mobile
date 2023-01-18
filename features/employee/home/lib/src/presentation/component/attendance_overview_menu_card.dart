import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class AttendanceOverviewMenuCard extends StatelessWidget {
  const AttendanceOverviewMenuCard({
    Key? key,
    required this.name,
    required this.color,
    required this.value,
    required this.subValue,
    this.onTap,
  }) : super(key: key);

  final String name;
  final Color color;
  final String value;
  final String subValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.dp8),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 130,
          maxWidth: 160,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimens.dp8),
          ),
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                    fontSize: Dimens.dp34,
                    color: color,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Dimens.dp4),
              Text(
                subValue,
                style: TextStyle(
                  fontSize: Dimens.dp12,
                  color: color.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: Dimens.dp16),
              Row(
                children: [
                  Icon(Icons.date_range_rounded,
                      size: Dimens.dp16, color: color),
                  const SizedBox(width: Dimens.dp8),
                  Text(
                    name,
                    style: TextStyle(color: color, fontSize: Dimens.dp14),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
