import 'package:attendance/attendance.dart';
import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../data/data.dart';
import '../../../component/component.dart';

class AttendanceOverviewSection extends StatelessWidget {
  const AttendanceOverviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceOverviewBloc, AttendanceOverviewState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SubTitle1Text(
                    '${S.of(context).attendance_overview} '
                    '(${DateFormat('MMM y').format(DateTime.now())})',
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildAction(context, state),
              ],
            ),
            const SizedBox(height: Dimens.dp16),
            _buildContent(context, state),
          ],
        );
      },
    );
  }

  Widget _buildAction(BuildContext context, AttendanceOverviewState state) {
    if (state is AttendanceOverviewSuccess) {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/attendance/log');
        },
        child: RegularText(
          S.of(context).view_all,
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      );
    } else if (state is AttendanceOverviewFailure) {
      return InkWell(
        onTap: () {
          BlocProvider.of<AttendanceOverviewBloc>(context)
              .add(FetchAttendanceOverviewEvent(
            date: DateTime.now(),
            refresh: true,
          ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh,
              size: Dimens.dp16,
              color: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(width: Dimens.dp4),
            RegularText(
              S.of(context).reload,
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _buildContent(BuildContext context, AttendanceOverviewState state) {
    if (state is AttendanceOverviewSuccess) {
      return _buildListMenu(context, state.data);
    }
    return _ContentLoading();
  }

  Widget _buildListMenu(BuildContext context, AttendanceOverviewEntity data) {
    var _listContent = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: AttendanceOverviewMenuData.getMenu(data)
          .map((menu) => Padding(
                padding: const EdgeInsets.only(right: Dimens.dp16),
                child: AttendanceOverviewMenuCard(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/attendance/log',
                      arguments: {
                        'type': AttendanceLogContentType.logs,
                        'log_filter': menu['type'],
                      },
                    );
                  },
                  color: menu['color'],
                  name: menu['label'],
                  value: menu['value'],
                  subValue: menu['sub_value'],
                ),
              ))
          .toList(),
    );

    if (Dimens.width(context) >= 450) {
      return _listContent;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: _listContent,
    );
  }
}

class _ContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildListMenu(context);
  }

  Widget _buildListMenu(BuildContext context) {
    var _count = 0;
    final _maxCount = Dimens.width(context) ~/ 60;
    if (_maxCount >= 5) {
      _count = 5;
    } else {
      _count = _maxCount;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_count, (index) => index)
          .map(
            (e) => Column(
              children: const [
                Skeleton(
                  height: 55,
                  width: 55,
                  radius: Dimens.dp30,
                ),
                SizedBox(height: Dimens.dp8),
                Skeleton(
                  width: 55,
                  height: Dimens.dp16,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
