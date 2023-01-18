import 'package:flutter/material.dart';

import '../../../notice.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Approval Request'),
        ),
        //   body: NestedScrollView(
        // physics: const BouncingScrollPhysics(),
        // headerSliverBuilder: (context, innerBoxIsScrolled) {
        //   return [_buildHeader()];
        // },
        body: const ApprovalPage(),
      ),
      // ),
    );
  }

  // Widget _buildHeader() {
  //   return SliverAppBar(
  //     title: Text(S.of(context).notice,
  //         style: const TextStyle(color: Colors.black)),
  //     pinned: true,
  //     snap: true,
  //     floating: true,
  //     expandedHeight: 120.0,
  //     automaticallyImplyLeading: false,
  //     bottom: TabBar(
  //       indicatorColor: StaticColors.red,
  //       tabs: [
  //         Tab(
  //           icon: Container(
  //             alignment: Alignment.center,
  //             child: Text(
  //               S.of(context).notification,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         ),
  //         Tab(
  //           icon: Container(
  //             alignment: Alignment.center,
  //             child: const Text(
  //               'Approval Request',
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildBodyTab() {
  //   return const TabBarView(
  //     physics: BouncingScrollPhysics(),
  //     children: <Widget>[
  //       NotificationPage(),
  //       ApprovalPage(),
  //     ],
  //   );
  // }

  // Widget _buildDotCountNotif(int count) {
  //   return Container(
  //     width: 20,
  //     height: 20,
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: Theme.of(context).primaryTextTheme.bodyText2?.color,
  //     ),
  //     child: Text(
  //       '$count',
  //       overflow: TextOverflow.fade,
  //       style: TextStyle(
  //           color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
}
