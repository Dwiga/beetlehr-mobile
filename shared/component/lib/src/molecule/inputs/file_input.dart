import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class FileInput extends StatefulWidget {
  final File? value;
  final String? label;
  final String? errorText;
  final ValueChanged<File> onChange;

  /// Example: ['pdf', 'png', 'jpg']
  final List<String>? allowExtension;

  const FileInput({
    Key? key,
    this.value,
    this.label,
    this.errorText,
    required this.onChange,
    this.allowExtension,
  }) : super(key: key);

  @override
  State<FileInput> createState() => _FileInputState();
}

class _FileInputState extends State<FileInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.value?.path.split('/').last ?? '';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FileInput oldWidget) {
    _controller.text = widget.value?.path.split('/').last ?? '';
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      label: widget.label,
      readOnly: true,
      errorText: widget.errorText,
      controller: (widget.value != null)
          ? TextEditingController(
              text: widget.value?.path.split('/').last ?? '')
          : null,
      onTap: _showDialogSelectFileMethod,
      suffix: InkWell(
        onDoubleTap: _showDialogSelectFileMethod,
        child: Container(
          width: Dimens.dp100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(Dimens.dp8),
            ),
            color: widget.errorText != null
                ? Theme.of(context).errorColor
                : Theme.of(context).primaryColorLight,
          ),
          child: Center(
            child: Text(
              S.of(context).browse_file,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _pickFile() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
      type: widget.allowExtension != null ? FileType.custom : FileType.any,
      allowedExtensions: widget.allowExtension,
    );
    if (result?.files != null && (result?.files.isNotEmpty ?? false)) {
      final path = result!.files.first.path ?? '';
      if (Platform.isIOS) {
        widget.onChange(File.fromUri(Uri.parse(path)));
      } else {
        widget.onChange(File(path));
      }
    }
  }

  void _showDialogSelectFileMethod() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => SelectFileMethod(
        onTapCamera: () {
          Navigator.of(context).pop();
          final picker = ImagePicker();

          picker
              .pickImage(
            source: ImageSource.camera,
            maxHeight: 500,
            maxWidth: 500,
            imageQuality: 50,
          )
              .then((file) {
            if (file?.path != null) {
              widget.onChange(File(file!.path));
            }
          });
        },
        onTapGallery: () {
          Navigator.of(context).pop();
          _pickFile();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
