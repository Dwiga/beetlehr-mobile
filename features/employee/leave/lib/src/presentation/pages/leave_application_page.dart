import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import 'leave_application_complete_page.dart';
import 'leave_application_inprocess_page.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({Key? key}) : super(key: key);

  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [_buildHeader()];
          },
          body: _buildBodyTab(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      title: Text(S.of(context).leave_application),
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 120.0,
      bottom: TabBar(
        indicatorColor: StaticColors.red,
        tabs: [
          Tab(text: S.of(context).in_process),
          Tab(text: S.of(context).completed),
        ],
      ),
    );
  }

  Widget _buildBodyTab() {
    return const TabBarView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        LeaveApplicationInProcessPage(),
        LeaveApplicationCompletedPage(),
      ],
    );
  }
}
