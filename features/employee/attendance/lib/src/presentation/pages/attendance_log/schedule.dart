import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../../attendance.dart';
import '../../component/component.dart';

class ScheduleLogsPage extends StatefulWidget {
  const ScheduleLogsPage({Key? key}) : super(key: key);

  @override
  _ScheduleLogsPageState createState() => _ScheduleLogsPageState();
}

class _ScheduleLogsPageState extends State<ScheduleLogsPage>
    with AutomaticKeepAliveClientMixin {
  int _currentPage = (AttendanceConfig.maxScheduleLog ~/ 2);

  List<DateTime> _dates = [];

  late ScheduleLogBloc _bloc;

  @override
  void initState() {
    _bloc = GetIt.I<ScheduleLogBloc>();
    _initAllDates();
    _fetchData(_dates[_currentPage]);
    super.initState();
  }

  void _initAllDates() {
    for (var i = 1; i <= AttendanceConfig.maxScheduleLog ~/ 2; i++) {
      _dates.add(DateTime(
        DateTime.now().year,
        DateTime.now().month - i,
      ));
    }

    setState(() {
      _dates = _dates.reversed.toList();
    });

    final _maxNextDateLength = AttendanceConfig.maxScheduleLog - _dates.length;

    for (var i = 0; i < _maxNextDateLength; i++) {
      _dates.add(DateTime(
        DateTime.now().year,
        DateTime.now().month + i,
      ));
    }
  }

  void _nextPage() {
    if (_currentPage < AttendanceConfig.maxScheduleLog) {
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
    _bloc.add(FetchScheduleLogEvent(
      startDate: DateTime(date.year, date.month, 1),
      endDate:
          DateTime(date.year, date.month + 1).subtract(const Duration(days: 1)),
    ));
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
                        _currentPage < (AttendanceConfig.maxScheduleLog - 1)
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
    return BlocBuilder<ScheduleLogBloc, ScheduleLogState>(
      builder: (context, state) {
        if (state is ScheduleLogSuccess &&
            state.period == _dates[_currentPage]) {
          return ListView.separated(
            padding: const EdgeInsets.only(
              left: Dimens.dp16,
              right: Dimens.dp16,
              bottom: Dimens.dp24,
            ),
            itemBuilder: (_, i) {
              return ScheduleLogCard(data: state.data[i]);
            },
            itemCount: state.data.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) {
              return const Divider();
            },
          );
        } else if (state is ScheduleLogFailure) {
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
