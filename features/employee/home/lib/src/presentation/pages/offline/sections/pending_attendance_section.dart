import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../../home.dart';

class PendingAttendanceSection extends StatelessWidget {
  const PendingAttendanceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PendingAttendancesBloc, PendingAttendancesState>(
      builder: (context, state) {
        if (state is PendingAttendancesSuccess && state.data.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubTitle1Text(S.of(context).attendance_log),
                const SizedBox(height: Dimens.dp4),
                RegularText(S.of(context).pending_data_attendance_message),
                for (final item in state.data) ...[
                  const SizedBox(height: Dimens.dp24),
                  SubTitle2Text('${DateFormat.yMMMEd().format(item.date)}'
                      '${item.date.isToday() ? '(Now)' : ''}'),
                  const SizedBox(height: Dimens.dp8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimens.dp8, horizontal: Dimens.dp16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.dp8),
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: Dimens.dp24,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: Dimens.dp8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).clock_in,
                                    style: TextStyle(
                                      fontSize: Dimens.dp12,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.dp4),
                                  SubTitle2Text(
                                    item.clockIn?.clock ?? '--:--',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: Dimens.dp40,
                            maxHeight: Dimens.dp50,
                          ),
                          child: const VerticalDivider(width: Dimens.dp32),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: Dimens.dp24,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: Dimens.dp8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).clock_out,
                                    style: TextStyle(
                                      fontSize: Dimens.dp12,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.dp4),
                                  SubTitle2Text(
                                    item.clockOut?.clock ?? '--:--',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
