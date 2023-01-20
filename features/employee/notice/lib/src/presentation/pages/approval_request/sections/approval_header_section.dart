import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:notice/notice.dart';
import 'package:notice/src/presentation/pages/approval_request/sections/sections.dart';
import 'package:preferences/preferences.dart';

class ApprovalHeaderSection extends StatefulWidget {
  final Color buttonColor;

  const ApprovalHeaderSection({Key? key, required this.buttonColor})
      : super(key: key);

  @override
  State<ApprovalHeaderSection> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalHeaderSection>
    with TickerProviderStateMixin {
  late TabController _controller;
  late AnimationController _animationControllerOn;
  late AnimationController _animationControllerOff;
  late Animation _colorTweenBackgroundOn;
  late Animation _colorTweenBackgroundOff;
  late Animation _colorTweenForegroundOn;
  late Animation _colorTweenForegroundOff;

  int _currentIndex = 1;
  int _prevControllerIndex = 0;
  double _aniValue = 0.0;
  double _prevAniValue = 0.0;
  bool isSelected = true;

  final List _icons = [Icons.filter_list_outlined, null, null, null];
  final List _title = ["Filter", "Awaiting", "Declined", "Approved"];

  late Color _foregroundOn;
  final Color? _foregroundOff = const Color.fromARGB(255, 136, 136, 136);
  late Color _backgroundOn;
  final Color? _backgroundOff = Colors.grey[200];
  final ScrollController _scrollController = ScrollController();
  final List _keys = [];

  bool _buttonTap = false;

  String? sortBy;
  List<EmployeeNameFilterEntity> employee = List.empty(growable: true);
  String? startTime;
  String? endTime;
  String? name;
  int? totalItemFilter = 0;

  @override
  void initState() {
    super.initState();

    _foregroundOn = widget.buttonColor;
    _backgroundOn = widget.buttonColor;

    for (int index = 0; index < _icons.length; index++) {
      _keys.add(GlobalKey());
    }

    _controller =
        TabController(vsync: this, length: _icons.length, initialIndex: 1);
    _controller.animation?.addListener(_handleTabAnimation);
    _controller.addListener(_handleTabChange);

    _animationControllerOff = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 75),
    );
    _animationControllerOff.value = 1.0;
    _colorTweenBackgroundOff =
        ColorTween(begin: _backgroundOn, end: _backgroundOff)
            .animate(_animationControllerOff);
    _colorTweenForegroundOff =
        ColorTween(begin: _foregroundOn, end: _foregroundOff)
            .animate(_animationControllerOff);

    _animationControllerOn = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animationControllerOn.value = 1.0;
    _colorTweenBackgroundOn =
        ColorTween(begin: _backgroundOff, end: _backgroundOn)
            .animate(_animationControllerOn);
    _colorTweenForegroundOn =
        ColorTween(begin: _foregroundOff, end: _foregroundOn)
            .animate(_animationControllerOn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: Dimens.dp8, vertical: Dimens.dp12),
            height: 50.0,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _icons.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  key: _keys[index],
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.dp6, horizontal: Dimens.dp4),
                  child: ButtonTheme(
                    child: AnimatedBuilder(
                      animation: _colorTweenBackgroundOn,
                      builder: (context, child) => ElevatedButton.icon(
                        icon: _icons[index] != null
                            ? totalItemFilter == 0
                                ? Icon(
                                    _icons[index],
                                    color: _getForegroundColor(index),
                                    size: Dimens.dp20,
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(Dimens.dp2),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimens.dp2,
                                        horizontal: Dimens.dp4),
                                    child: SmallText(
                                      totalItemFilter.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                            : const SizedBox(),
                        label: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimens.dp6),
                            child: RegularText(
                              _title[index],
                              style: TextStyle(
                                  color: _icons[index] != null
                                      ? totalItemFilter! > 0
                                          ? Theme.of(context).primaryColor
                                          : const Color.fromARGB(
                                              255, 136, 136, 136)
                                      : _getForegroundColor(index),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          side: BorderSide(
                              color: _icons[index] != null
                                  ? totalItemFilter! > 0
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[200]
                                  : _getBackgroundColor(index),
                              width: 0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.dp18),
                          ),
                          primary: Colors.white,
                        ),
                        onPressed: () => setState(
                          () {
                            if (index == 0) {
                              _openFilterViewSheet();
                            } else {
                              _buttonTap = true;
                              _controller.animateTo(index);
                              _setCurrentIndex(index);
                              _scrollTo(index);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                const WaitingListApprovalPage(),
                WaitingListApprovalPage(
                  statusLabel: ApprovalRequestType.awaiting,
                  startTime: startTime,
                  endTime: endTime,
                  sortBy: sortBy,
                ),
                WaitingListApprovalPage(
                  statusLabel: ApprovalRequestType.rejected,
                  startTime: startTime,
                  endTime: endTime,
                  sortBy: sortBy,
                ),
                WaitingListApprovalPage(
                  statusLabel: ApprovalRequestType.approved,
                  startTime: startTime,
                  endTime: endTime,
                  sortBy: sortBy,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _handleTabAnimation() {
    _aniValue = _controller.animation!.value;

    if (!_buttonTap && ((_aniValue - _prevAniValue).abs() < 1)) {
      _setCurrentIndex(_aniValue.round());
    }

    _prevAniValue = _aniValue;
  }

  _handleTabChange() {
    if (_buttonTap) _setCurrentIndex(_controller.index);

    if ((_controller.index == _prevControllerIndex) ||
        (_controller.index == _aniValue.round())) _buttonTap = false;

    _prevControllerIndex = _controller.index;
  }

  _setCurrentIndex(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      _triggerAnimation();
      _scrollTo(index);
    }
  }

  _triggerAnimation() {
    _animationControllerOn.reset();
    _animationControllerOff.reset();

    _animationControllerOn.forward();
    _animationControllerOff.forward();
  }

  _scrollTo(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    RenderBox renderBox = _keys[index].currentContext.findRenderObject();
    double size = renderBox.size.width;
    double position = renderBox.localToGlobal(Offset.zero).dx;
    double offset = (position + size / 2) - screenWidth / 2;

    if (offset < 0) {
      renderBox = _keys[0].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;

      if (position > offset) offset = position;
    } else {
      renderBox = _keys[_icons.length - 1].currentContext.findRenderObject();
      position = renderBox.localToGlobal(Offset.zero).dx;
      size = renderBox.size.width;

      if (position + size < screenWidth) screenWidth = position + size;

      if (position + size - offset < screenWidth) {
        offset = position + size - screenWidth;
      }
    }

    _scrollController.animateTo(offset + _scrollController.offset,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  }

  _getBackgroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenBackgroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenBackgroundOff.value;
    } else {
      return _backgroundOff;
    }
  }

  _getForegroundColor(int index) {
    if (index == _currentIndex) {
      return _colorTweenForegroundOn.value;
    } else if (index == _prevControllerIndex) {
      return _colorTweenForegroundOff.value;
    } else {
      return _foregroundOff;
    }
  }

  Future<void> _openFilterViewSheet() async {
    final result = await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterDialogPage(
        sortByValue: sortBy ?? "",
        time: ApprovalTimeRangeEntity(
            startTime: startTime ?? "", endTime: endTime ?? ""),
        totalItemFilter: totalItemFilter,
      ),
    );

    setState(() {
      if (result is ApprovalRequestFilterEntity) {
        sortBy = result.sortBy;
        startTime = result.startTime;
        endTime = result.endTime;
        totalItemFilter = result.totalItemFilter;
      }
    });
  }
}
