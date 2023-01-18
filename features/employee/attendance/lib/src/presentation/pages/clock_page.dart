import 'dart:io';

import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../attendance.dart';

class ClockPage extends StatefulWidget {
  final ClockAcceptModel clockAccept;
  final VoidCallback? onPressNext;
  final TextEditingController? noteController;
  final bool isClockOut;
  final ValueChanged<List<File>>? onChangeFiles;
  final int maxInputFiles;
  final bool showLocationAlert;
  final bool showTimeAlert;
  final bool requiredInputFiles;
  final bool requiredInputNotes;
  final bool showInputFiles;

  const ClockPage({
    Key? key,
    required this.clockAccept,
    this.onPressNext,
    this.noteController,
    this.isClockOut = false,
    this.onChangeFiles,
    this.maxInputFiles = 3,
    this.showTimeAlert = true,
    this.showLocationAlert = true,
    this.requiredInputFiles = false,
    this.requiredInputNotes = false,
    this.showInputFiles = true,
  }) : super(key: key);

  @override
  _ClockPageState createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  String _text = '';
  final List<File> _files = [];

  bool get isOptionalInput => !widget.requiredInputNotes || isAccept;

  bool get isAccept =>
      (widget.clockAccept.acceptedImage ?? false) &&
      (widget.clockAccept.acceptedLocation ?? false) &&
      !(widget.clockAccept.isLate ?? false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimens.dp16),
        children: [
          if (widget.showTimeAlert) ...[
            _buildAlertTime(),
            const SizedBox(height: Dimens.dp16)
          ],
          if (widget.showLocationAlert) ...[
            _buildAlertRadius(),
            const SizedBox(height: Dimens.dp16)
          ],
          _buildForm(),
        ],
      ),
      bottomNavigationBar: _buildButton(),
    );
  }

  Widget _buildAlertTime() {
    if (widget.clockAccept.isLate ?? false) {
      return AlertMessage.danger(
        Text(widget.isClockOut
            ? S.of(context).message_home_early
            : S.of(context).message_alert_late),
        icon: AppIcons.clockLine,
      );
    }
    return AlertMessage.success(
      Text(widget.isClockOut
          ? S.of(context).message_leave_on_time
          : S.of(context).message_alert_on_time),
      icon: AppIcons.clockLine,
    );
  }

  Widget _buildAlertRadius() {
    if (widget.clockAccept.acceptedLocation ?? false) {
      return AlertMessage.success(
        Text(S.of(context).location_in_radius),
        icon: AppIcons.mapMarkerLine,
      );
    }
    return AlertMessage.danger(
      Text(S.of(context).location_out_radius),
      icon: AppIcons.mapMarkerLine,
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextAreaInput(
          onChange: (v) {
            setState(() {
              _text = v;
            });
          },
          controller: widget.noteController,
          isRequired: !isOptionalInput,
          label: '${S.of(context).write_note_to_supervisor} '
              '${isOptionalInput ? '(Optional)' : ''}',
        ),
        const SizedBox(height: Dimens.dp8),
        if (!isAccept && widget.showInputFiles) ...[
          Text(
            S.of(context).message_describe_reason_clock,
            style: TextStyle(color: Theme.of(context).disabledColor),
          ),
          const SizedBox(height: Dimens.dp24),
          _buildFilesInput(),
        ],
      ],
    );
  }

  Widget _buildFilesInput() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InputLabel(
                label: S.of(context).upload_support_file,
                isRequired: widget.requiredInputFiles,
              ),
            ),
            SubTitle1Text('${_files.length}/${widget.maxInputFiles}'),
          ],
        ),
        const SizedBox(height: Dimens.dp8),
        ListView.separated(
          itemBuilder: (context, index) {
            return FileInput(
              allowExtension: const ['png', 'jpg', 'jpeg', 'mp4', 'pdf'],
              value: _files.length > index ? _files[index] : null,
              onChange: (file) {
                var _isUniqueFile = true;
                for (var item in _files) {
                  if (item.path == file.path) {
                    _isUniqueFile = false;
                  }
                }

                if (_isUniqueFile) {
                  setState(() {
                    if (_files.length > index) {
                      _files[index] = file;
                    } else {
                      _files.add(file);
                    }
                  });

                  widget.onChangeFiles?.call(_files);
                }
              },
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: Dimens.dp16),
          itemCount: _files.length < widget.maxInputFiles
              ? _files.length + 1
              : widget.maxInputFiles,
        )
      ],
    );
  }

  Widget _buildButton() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.dp16, 0, Dimens.dp16, Dimens.dp16),
            child: PrimaryButton(
              onPressed:
                  (isOptionalInput || (_text.isNotEmpty && isFilesValid()))
                      ? widget.onPressNext
                      : null,
              child: Text(S.of(context).next),
            ),
          ),
        ],
      ),
    );
  }

  bool isFilesValid() {
    if (widget.requiredInputFiles) {
      return _files.isNotEmpty;
    }
    return true;
  }
}
