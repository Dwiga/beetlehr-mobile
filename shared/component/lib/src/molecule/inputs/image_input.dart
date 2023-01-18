import 'dart:io';

import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class ImageInput extends StatefulWidget {
  final File? initialImage;
  final String? label;
  final bool? isRequired;
  final String? hintText;
  final ValueChanged<File> onChange;
  final ImageSource? source;
  final bool? readOnly;
  final String? imageNetwork;
  final double? width;
  final double? height;

  const ImageInput({
    Key? key,
    this.initialImage,
    this.label,
    this.isRequired,
    this.hintText,
    required this.onChange,
    this.source = ImageSource.camera,
    this.readOnly = false,
    this.imageNetwork,
    this.width = 160,
    this.height = 160,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _currentImage;
  final picker = ImagePicker();

  Future _pickImage() async {
    final pickedFile = await picker.pickImage(
      source: widget.source ?? ImageSource.camera,
      maxHeight: 500,
      maxWidth: 500,
      imageQuality: 50,
    );

    setState(() {
      if (pickedFile != null) {
        _currentImage = File(pickedFile.path);
        widget.onChange(_currentImage!);
      }
    });
  }

  @override
  void initState() {
    if (widget.initialImage != null) {
      _currentImage = widget.initialImage;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? InputLabel(label: widget.label!, isRequired: widget.isRequired)
            : const SizedBox(),
        (widget.readOnly ?? false)
            ? _buildNetworkImage()
            : _buildEditModeImage(),
        const SizedBox(height: Dimens.dp8),
        _buildButtonAction(),
      ],
    );
  }

  Widget _buildEditModeImage() {
    if (_currentImage != null) {
      return _buildExistImage();
    } else if (widget.imageNetwork != null) {
      return _buildNetworkImage();
    }

    return _buildEmptyImage();
  }

  Widget _buildEmptyImage() {
    return Container(
      width: widget.width,
      height: widget.width,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).primaryColorLight, width: 1),
        borderRadius: BorderRadius.circular(Dimens.dp4),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: SmallText(
            widget.hintText ?? '',
            style: TextStyle(color: Theme.of(context).primaryColorLight),
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildExistImage() {
    return Container(
        width: widget.width,
        height: widget.width,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColorLight, width: 1),
            borderRadius: BorderRadius.circular(Dimens.dp4),
            image: DecorationImage(
                image: FileImage(_currentImage!), fit: BoxFit.cover)));
  }

  Widget _buildNetworkImage() {
    return Container(
      width: widget.width,
      height: widget.width,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).primaryColorLight, width: 1),
        borderRadius: BorderRadius.circular(Dimens.dp4),
        image: widget.imageNetwork != null
            ? DecorationImage(
                image: NetworkImage(widget.imageNetwork!), fit: BoxFit.cover)
            : null,
      ),
    );
  }

  Widget _buildButtonAction() {
    return !(widget.readOnly ?? false)
        ? SmallButton(
            child: Text(S.of(context).select_image),
            onPressed: _pickImage,
          )
        : const SizedBox();
  }
}
