import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../notice.dart';

class RequestDetailInformationSection extends StatelessWidget {
  final ApprovalRequestDetailEntity data;

  const RequestDetailInformationSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.dp16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimens.dp16),
        ),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(145, 241, 241, 241),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegularText(
            S.of(context).approval_request_information,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: Dimens.dp16),
          if (data.type == "time_off") ...[
            _requestInformation(context)
          ] else ...[
            Html(data: data.metaData.note)
          ]
        ],
      ),
    );
  }

  Widget _requestInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: RegularText(S.of(context).type),
            ),
            const RegularText(":  "),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                  vertical: Dimens.dp2, horizontal: Dimens.dp8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.dp2),
                ),
                color: Color.fromARGB(155, 253, 223, 177),
              ),
              child: RegularText(
                data.metaData.typeLabel ?? '',
                style: const TextStyle(
                    color: Colors.orange, fontSize: Dimens.dp12),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: RegularText(S.of(context).duration),
            ),
            const RegularText(":  "),
            RegularText("${data.metaData.duration} ${S.of(context).days}"),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: RegularText(S.of(context).date),
            ),
            const RegularText(":  "),
            RegularText(
                "${formateDateWithoutYear(data.metaData.startTime.toString())} - ${formateDateWithYear(data.metaData.endTime.toString())}",
                maxLine: 5),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: RegularText(S.of(context).reason),
            ),
            const RegularText(":  "),
            Expanded(
              child: RegularText(data.metaData.reason.toString(), maxLine: 5),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              child: RegularText(S.of(context).additional_file),
            ),
            const RegularText(":  "),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(data.metaData.additionalFile.toString(),
                  height: 100.0, width: 100.0, fit: BoxFit.cover),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }

  String formateDateWithYear(String dateTime) {
    var inputFormat = DateFormat('y-MM-dd');
    var inputDate = inputFormat.parse(dateTime.toString());
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  String formateDateWithoutYear(String dateTime) {
    var inputFormat = DateFormat('y-MM-dd');
    var inputDate = inputFormat.parse(dateTime.toString());
    var outputFormat = DateFormat('dd MMM');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }
}
