import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../attendance.dart';
import '../../component/component.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({Key? key, this.logStatus}) : super(key: key);

  final AttendanceLogType? logStatus;

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>
    with AutomaticKeepAliveClientMixin {
  int _currentPage = AttendanceConfig.maxAttendanceLog - 1;
  List<DateTime> _dates = [];

  late AttendanceLogBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<AttendanceLogBloc>(context);
    _initAllDates();
    _fetchData(_dates[_currentPage]);
    super.initState();
  }

  void _initAllDates() {
    for (var i = 0; i < AttendanceConfig.maxAttendanceLog; i++) {
      _dates.add(DateTime(
        DateTime.now().year,
        DateTime.now().month - i,
      ));
    }
    _dates = _dates.reversed.toList();
  }

  void _nextPage() {
    if (_currentPage < AttendanceConfig.maxAttendanceLog) {
      setState(() {
        _currentPage++;
      });
      _fetchData(_dates[_currentPage]);
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchData(_dates[_currentPage]);
    }
  }

  void _fetchData(DateTime date) {
    _bloc.add(
      FetchAttendanceLogEvent(
        period: date,
        status: widget.logStatus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _bloc,
      child: Column(
        children: [
          FutureBuilder(
              future: Future.value(true),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _Header(
                    currentDate: _dates[_currentPage],
                    onTapNext:
                        _currentPage < (AttendanceConfig.maxAttendanceLog - 1)
                            ? _nextPage
                            : null,
                    onTapPrevious: _currentPage > 1 ? _previousPage : null,
                  );
                }
                return _Header(
                  currentDate: _dates.last,
                  onTapNext: null,
                  onTapPrevious: _previousPage,
                );
              }),
          Expanded(
            child: _buildPageViews(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageViews() {
    return BlocBuilder<AttendanceLogBloc, AttendanceLogState>(
      builder: (context, state) {
        if (state is AttendanceLogSuccess &&
            state.period == _dates[_currentPage]) {
          return ListView.separated(
            padding: const EdgeInsets.only(
              left: Dimens.dp16,
              right: Dimens.dp16,
              bottom: Dimens.dp24,
            ),
            itemBuilder: (_, i) {
              return InkWell(
                onTap: () {
                  _navigateToDetail(state.data[i].date);
                },
                child: AttendanceLogCard(
                  date: state.data[i].date,
                  clockInTime: Utils.durationTimeParse(state.data[i].clockIn),
                  clockOutTime: Utils.durationTimeParse(state.data[i].clockOut),
                  worksHours: Utils.durationTimeParse(state.data[i].workHours),
                  type: _getType(state.data[i].status),
                  isForceClockOut: state.data[i].isForceClockOut,
                ),
              );
            },
            itemCount: state.data.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) {
              return const Divider();
            },
          );
        } else if (state is AttendanceLogFailure) {
          return ErrorMessageWidget(
            message: state.failure.message,
            onPress: () {
              _fetchData(_dates[_currentPage]);
            },
          );
        }
        return _Loading();
      },
    );
  }

  void _navigateToDetail(DateTime date) {
    Navigator.pushNamed(context, '/attendance/detail', arguments: {
      'date': date,
    });
  }

  AttendanceLogCardType _getType(AttendanceLogType? status) {
    switch (status) {
      case AttendanceLogType.absent:
      case AttendanceLogType.leave:
        return AttendanceLogCardType.absent;
      case AttendanceLogType.holiday:
        return AttendanceLogCardType.holiday;
      default:
        return AttendanceLogCardType.normal;
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class _Header extends StatelessWidget {
  final DateTime currentDate;
  final VoidCallback? onTapNext;
  final VoidCallback? onTapPrevious;
  const _Header({
    Key? key,
    required this.currentDate,
    this.onTapNext,
    this.onTapPrevious,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: onTapPrevious != null
          ? IconButton(
              onPressed: onTapPrevious,
              color: Theme.of(context).textTheme.headline6?.color,
              icon: const Icon(Icons.chevron_left),
            )
          : const IconButton(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.transparent,
              ),
              onPressed: null),
      title: SubTitle1Text(
        DateFormat('MMMM yyyy').format(currentDate),
        align: TextAlign.center,
      ),
      trailing: onTapNext != null
          ? IconButton(
              onPressed: onTapNext,
              color: Theme.of(context).textTheme.headline6?.color,
              icon: const Icon(Icons.chevron_right),
            )
          : const IconButton(
              icon: Icon(
                Icons.ac_unit,
                color: Colors.transparent,
              ),
              onPressed: null),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Row(
          children: [
            const Skeleton(
              width: Dimens.dp50,
              height: Dimens.dp50,
            ),
            const SizedBox(width: Dimens.dp24),
            Expanded(
              child: Column(
                children: const [
                  Skeleton(
                    width: double.infinity,
                    height: Dimens.dp20,
                  ),
                  SizedBox(height: Dimens.dp12),
                  Skeleton(
                    width: double.infinity,
                    height: Dimens.dp16,
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (_, __) {
        return const Divider();
      },
      itemCount: 10,
    );
  }
}
