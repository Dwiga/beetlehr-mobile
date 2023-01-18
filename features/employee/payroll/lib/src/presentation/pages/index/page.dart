import 'package:dependencies/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../../payroll.dart';
import '../payroll_filter_page.dart';

class PayrollPage extends StatefulWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  _PayrollPageState createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage>
    with SingleTickerProviderStateMixin {
  Map<String, int?>? _filterDate;
  final _payrollBloc = GetIt.I<PayrollBloc>();
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _payrollBloc,
        ),
        BlocProvider(
          create: (context) => GetIt.I<PayrollTHRBloc>(),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).payroll),
            actions: [_buildActionFilter()],
          ),
          body: const ListPayrollPage()),
    );
  }

  Widget _buildActionFilter() {
    return IconButton(
      icon: const Icon(AppIcons.filterSolid),
      onPressed: _navigateToFilter,
    );
  }

  void _navigateToFilter() async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => PayrollFilterPage(
          initialDate: _filterDate,
        ),
      ),
    );

    if (result != null && result is Map<String, int?>) {
      setState(
        () {
          _filterDate = result;
          _payrollBloc.add(FetchPayrollEvent(
            year: result['year'],
            month: result['month'],
            page: 1,
            perPage: 10,
          ));
        },
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
