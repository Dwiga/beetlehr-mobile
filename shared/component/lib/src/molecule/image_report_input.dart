import 'dart:io';

import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class ImageReportInput extends StatelessWidget {
  const ImageReportInput({Key? key, required this.onChange}) : super(key: key);

  final ValueChanged<File> onChange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimens.dp4),
      onTap: () => _showFileMethodDialog(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.dp4),
          color: Theme.of(context).disabledColor.withOpacity(0.1),
        ),
        width: Dimens.dp100,
        height: Dimens.dp100,
        child: Center(
          child: Container(
            width: Dimens.dp30,
            height: Dimens.dp30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight,
            ),
            child: const Icon(
              Icons.add,
              size: Dimens.dp16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showFileMethodDialog(BuildContext context) {
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
              onChange(File(file!.path));
            }
          });
        },
        onTapGallery: () {
          Navigator.of(context).pop();
          _pickFromFile();
        },
      ),
    );
  }

  void _pickFromFile() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowCompression: true,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );
    if (result?.files != null && (result?.files.isNotEmpty ?? false)) {
      final path = result!.files.first.path ?? '';
      if (Platform.isIOS) {
        onChange(File.fromUri(Uri.parse(path)));
      } else {
        onChange(File(path));
      }
    }
  }
}
