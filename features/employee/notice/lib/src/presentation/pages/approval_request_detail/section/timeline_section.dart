import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:l10n/l10n.dart';

import '../../../../../notice.dart';
import 'sections.dart';

class TimeLineSection extends StatelessWidget {
  final ApprovalRequestDetailEntity data;

  const TimeLineSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(Dimens.dp16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimens.dp16),
          ),
          color: Colors.white,
          border: Border.all(color: const Color.fromARGB(145, 241, 241, 241)),
        ),
        child: ListView.builder(
          itemCount: data.approvers.length,
          itemBuilder: (context, index) {
            final item = data.approvers[index];
            return TimelineTile(
              isFirst: index == 0,
              isLast: index == (data.approvers.length - 1),
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              indicatorStyle: IndicatorStyle(
                width: 30,
                height: 30,
                indicatorXY: 0.0,
                drawGap: true,
                indicator: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(Dimens.dp16)),
                      color: getColorTimeLine(data, context),
                    ),
                    child: getIcon(data)),
              ),
              beforeLineStyle: LineStyle(
                color: Theme.of(context).dividerColor,
                thickness: Dimens.dp4,
              ),
              afterLineStyle: LineStyle(
                color: Theme.of(context).dividerColor,
                thickness: Dimens.dp4,
              ),
              startChild: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    top: item.timestamp!.isNotEmpty ? 0 : Dimens.dp6,
                    right: Dimens.dp8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: RegularText(
                        item.timestamp!.isNotEmpty
                            ? formateDateTimeLine(item.timestampGmt.toString())
                            : S.of(context).pending,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    if (item.timestampGmt!.isNotEmpty) ...[
                      const SizedBox(width: 20)
                    ] else ...[
                      const SizedBox()
                    ],
                    Expanded(
                      child: SmallText(
                        item.timestamp!.isNotEmpty
                            ? formateDateTimeLineWorldFormat(
                                item.timestampGmt.toString())
                            : '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              endChild: Container(
                padding: const EdgeInsets.only(
                  left: Dimens.dp16,
                ),
                child: UserInformatioSection(data: data, index: index),
              ),
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  Widget getIcon(ApprovalRequestDetailEntity data) {
    if (data.status == ApprovalRequestType.awaiting) {
      return const Icon(
        Icons.access_time,
        size: Dimens.dp16,
        color: Colors.white,
      );
    } else if (data.status == ApprovalRequestType.approved) {
      return const Icon(Icons.check, size: Dimens.dp16, color: Colors.white);
    } else if (data.status == ApprovalRequestType.rejected) {
      return const Icon(
        Icons.close,
        size: Dimens.dp16,
        color: Colors.white,
      );
    } else {
      return const Icon(
        Icons.block_sharp,
        size: Dimens.dp16,
        color: Colors.white,
      );
    }
  }

  Color getColor(ApprovalRequestDetailEntity data) {
    if (data.status == ApprovalRequestType.awaiting) {
      return Colors.orange;
    } else if (data.status == ApprovalRequestType.rejected) {
      return Colors.red;
    } else if (data.status == ApprovalRequestType.approved) {
      return Colors.green;
    } else {
      return Colors.purple;
    }
  }

  Color getColorTimeLine(
      ApprovalRequestDetailEntity data, BuildContext context) {
    if (data.status == ApprovalRequestType.awaiting) {
      return Theme.of(context).dividerColor;
    } else if (data.status == ApprovalRequestType.rejected) {
      return Colors.red;
    } else if (data.status == ApprovalRequestType.approved) {
      return Colors.green;
    } else {
      return Colors.purple;
    }
  }

  String formateDateTimeLine(String dateTime) {
    var inputFormat = DateFormat('y-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(dateTime.toString());
    var outputFormat = DateFormat('dd MMM');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String formateDateTimeLineWorldFormat(String dateTime) {
    var inputFormat = DateFormat('y-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(dateTime.toString());
    var outputFormat = DateFormat('HH:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}
