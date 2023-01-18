import 'dart:io';

import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../attendance.dart';
import 'view_location_page.dart';
import 'view_photo_page.dart';

class DetailAttendancePage extends StatefulWidget {
  final DateTime date;
  final VoidCallback? onBack;
  const DetailAttendancePage({
    Key? key,
    required this.date,
    this.onBack,
  }) : super(key: key);
  @override
  _DetailAttendancePageState createState() => _DetailAttendancePageState();
}

class _DetailAttendancePageState extends State<DetailAttendancePage> {
  final AttendanceDetailBloc _bloc = GetIt.I<AttendanceDetailBloc>();
  final DownloadFileBloc _downloadFileBloc = GetIt.I<DownloadFileBloc>();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    _bloc.add(FetchAttendanceDetailEvent(widget.date));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onBack?.call();
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _bloc,
          ),
          BlocProvider(
            create: (_) => _downloadFileBloc,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Detail'),
          ),
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<DownloadFileBloc, DownloadFileState>(
      listener: (context, state) {
        if (state is DownloadFileLoading) {
          IndicatorsUtils.showMessageSnackbar(
              context, S.of(context).start_downloading_file);
        }
      },
      child: BlocBuilder<AttendanceDetailBloc, AttendanceDetailState>(
        builder: (context, state) {
          if (state is AttendanceDetailSuccess) {
            return _buildContent(state.data);
          } else if (state is AttendanceDetailFailure) {
            return SizedBox(
              width: double.infinity,
              child: ErrorMessageWidget(
                message: state.failure.message,
                onPress: _fetchData,
              ),
            );
          }
          return _ContentLoading();
        },
      ),
    );
  }

  Widget _buildContent(AttendanceDetailDataEntity data) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      children: [
        SubTitle2Text(
          '${S.of(context).attendance} ('
          '${DateFormat.yMMMMEEEEd().format(widget.date)}'
          ')',
        ),
        const SizedBox(height: Dimens.dp16),
        _buildTotalWorks(data.totalHours ?? '-'),
        const SizedBox(height: Dimens.dp16),
        _buildTimeline(data.attendances),
        const SizedBox(height: Dimens.dp24),
        _buildReportFiles(data),
      ],
    );
  }

  Widget _buildTotalWorks(String totalHours) {
    return AlertMessage.primary(
      RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.white),
            text: '${S.of(context).total_hours_worked}: ',
            children: [
              TextSpan(
                text: Utils.durationToClock(
                        Utils.durationTimeParse(totalHours)) ??
                    '-',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' ${S.of(context).hours}',
              ),
            ]),
      ),
      icon: AppIcons.clockLine,
    );
  }

  Widget _buildTimeline(List<AttendanceDetailEntity> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return TimelineTile(
          isFirst: index == 0,
          isLast: index == (data.length - 1),
          alignment: TimelineAlign.start,
          indicatorStyle: const IndicatorStyle(
            width: Dimens.dp16,
            height: Dimens.dp16,
            drawGap: true,
            indicator: Icon(
              Icons.panorama_fish_eye,
              color: StaticColors.red,
              size: Dimens.dp16,
            ),
          ),
          beforeLineStyle: LineStyle(
            color: Theme.of(context).dividerColor,
            thickness: Dimens.dp4,
          ),
          afterLineStyle: LineStyle(
            color: Theme.of(context).dividerColor,
            thickness: Dimens.dp4,
          ),
          endChild: Container(
            padding: const EdgeInsets.only(
              left: Dimens.dp16,
              bottom: Dimens.dp16,
            ),
            constraints: const BoxConstraints(minHeight: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${_getTypeAttendance(item.type)} - '),
                    SubTitle2Text(
                      Utils.durationToClock(
                              Utils.durationTimeParse(item.clock)) ??
                          '-',
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.dp4),
                Row(
                  children: [
                    item.image?.url != null
                        ? _buildViewPhoto(item.image?.url ?? '')
                        : const SizedBox(),
                    _buildViewLocation(item),
                  ],
                ),
                const SizedBox(height: Dimens.dp4),
                RegularText(item.address ?? ''),
                const SizedBox(height: Dimens.dp4),
                RegularText(
                  '${S.of(context).note} : ${item.notes ?? '-'}',
                  style: TextStyle(color: Theme.of(context).disabledColor),
                ),
              ],
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildViewPhoto(String image) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ViewPhotoPage(imageUrl: image),
            ));
      },
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                AppIcons.imageSolid,
                color: Theme.of(context).primaryColorLight,
                size: Dimens.dp14,
              ),
              const SizedBox(width: Dimens.dp4),
              RegularText(
                S.of(context).view_photo,
                style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                ),
              )
            ],
          ),
          const SizedBox(width: Dimens.dp16),
        ],
      ),
    );
  }

  Widget _buildViewLocation(AttendanceDetailEntity data) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) => ViewLocationPage(
                latitude: data.latitude,
                longitude: data.longitude,
              ),
            ));
      },
      child: Row(
        children: [
          const Icon(
            AppIcons.mapMarkerSolid,
            color: StaticColors.red,
            size: Dimens.dp14,
          ),
          const SizedBox(width: Dimens.dp4),
          RegularText(
            S.of(context).view_location,
            style: const TextStyle(
              color: StaticColors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReportFiles(AttendanceDetailDataEntity data) {
    if (data.attendances.isNotEmpty &&
        _getAttendancesFiles(data.attendances).isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle2Text(S.of(context).report_files),
          const SizedBox(height: Dimens.dp16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          for (var fileUrl in _getAttendancesFiles(data.attendances)) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.dp8),
              child: InkWell(
                onTap: () {
                  _downloadFileBloc.add(
                    GetDownloadFileEvent(
                      url: fileUrl,
                      fileName: fileUrl.split('/').last,
                      showNotification: true,
                      withHttpClient: Platform.isIOS,
                    ),
                  );
                },
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Dimens.width(context) * 0.7,
                      ),
                      child: SubTitle2Text(
                        fileUrl.split('/').last,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                        ),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: Dimens.dp8),
                    Icon(
                      Icons.file_download,
                      size: Dimens.dp24,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      );
    }
    return const SizedBox();
  }

  List<String> _getAttendancesFiles(List<AttendanceDetailEntity> data) {
    final _result = <String>[];

    for (var item in data) {
      if (item.files != null) {
        for (var fileUrl in item.files!) {
          _result.add(fileUrl);
        }
      }
    }
    return _result;
  }

  String _getTypeAttendance(AttendanceClockType? type) {
    switch (type) {
      case AttendanceClockType.clockIn:
        return S.of(context).clock_in;
      case AttendanceClockType.clockOut:
        return S.of(context).clock_out;
      default:
        return '';
    }
  }
}

class _ContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      children: const [
        Skeleton(
          width: Dimens.dp50,
          height: Dimens.dp16,
        ),
        SizedBox(height: Dimens.dp16),
        Skeleton(
          width: double.infinity,
          height: Dimens.dp48,
        ),
        SizedBox(height: Dimens.dp16),
        Skeleton(
          width: double.infinity,
          height: 60,
        ),
        SizedBox(height: Dimens.dp16),
        Skeleton(
          width: double.infinity,
          height: 60,
        ),
        SizedBox(height: Dimens.dp16),
        Skeleton(
          width: double.infinity,
          height: 60,
        ),
      ],
    );
  }
}
