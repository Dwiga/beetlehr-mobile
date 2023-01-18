import 'dart:io';

import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../profile.dart';

enum FormProfileType { viewOnly, edit }

class FormProfilePage extends StatefulWidget {
  final FormProfileType type;
  final ProfileEntity? initialData;

  const FormProfilePage(
      {Key? key, this.type = FormProfileType.viewOnly, this.initialData})
      : super(key: key);

  @override
  _FormProfilePageState createState() => _FormProfilePageState();
}

class _FormProfilePageState extends State<FormProfilePage> {
  ManipulateProfileBloc? _bloc;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telegramIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankNumberController = TextEditingController();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _networkImage;
  File? _image;

  bool get isEdit => widget.type == FormProfileType.edit;

  void _initData() {
    if (widget.initialData != null) {
      _nameController.text = widget.initialData?.name ?? '';
      _emailController.text = widget.initialData?.email ?? '';
      _phoneNumberController.text = widget.initialData?.phoneNumber ?? '';
      _designationController.text = widget.initialData?.designation ?? '';
      _addressController.text = widget.initialData?.address ?? '';
      _bankNameController.text = widget.initialData?.accountNumber ?? '';
      _nipController.text = widget.initialData?.nip ?? '';
      _networkImage = widget.initialData?.image;
    }
  }

  void _initChangeData() {
    _bloc?.add(ManipulateProfileChangeName(widget.initialData?.name ?? ''));
    _bloc?.add(ManipulateProfileChangeEmail(widget.initialData?.email ?? ''));
    _bloc?.add(
        ManipulateProfileChangePhone(widget.initialData?.phoneNumber ?? ''));
    _bloc?.add(
        ManipulateProfileChangeAddress(widget.initialData?.address ?? ''));
    _bloc?.add(ManipulateProfileChangeAccountNumber(
        widget.initialData?.accountNumber ?? ''));
    _bloc
        ?.add(ManipulateProfileChangeImageUrl(widget.initialData?.image ?? ''));
    _bloc?.add(ManipulateProfileChangeNip(widget.initialData?.nip ?? ''));

    // Init Listener Controller
    _nameController.addListener(
      () => _bloc?.add(ManipulateProfileChangeName(_nameController.text)),
    );
    _emailController.addListener(
      () => _bloc?.add(ManipulateProfileChangeEmail(_emailController.text)),
    );
    _addressController.addListener(
      () => _bloc?.add(ManipulateProfileChangeAddress(_addressController.text)),
    );
    _bankNameController.addListener(
      () => _bloc
          ?.add(ManipulateProfileChangeAccountNumber(_bankNameController.text)),
    );
    _nipController.addListener(
      () => _bloc?.add(ManipulateProfileChangeNip(_nipController.text)),
    );
  }

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      _bloc = BlocProvider.of<ManipulateProfileBloc>(context);
    }
    _initData();

    if (isEdit) {
      _initChangeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManipulateProfileBloc, ManipulateProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildButtonAction(state),
        );
      },
    );
  }

  Widget _buildBody(ManipulateProfileState state) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.dp16),
      children: [
        if (widget.type == FormProfileType.edit) ...[
          _buildCannotEditInformation(),
          const SizedBox(height: Dimens.dp16)
        ],
        RegularTextInput(
          controller: _nameController,
          label: S.of(context).name,
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        RegularTextInput(
          controller: _designationController,
          label: S.of(context).designation,
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        RegularTextInput(
          controller: _emailController,
          label: S.of(context).email,
          inputType: TextInputType.emailAddress,
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        RegularTextInput(
          label: S.of(context).phone_number,
          controller: _phoneNumberController,
          inputType: TextInputType.phone,
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        TextAreaInput(
          controller: _addressController,
          label: S.of(context).address,
          minLine: 5,
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        RegularTextInput(
          controller: _bankNameController,
          label: S.of(context).bank_number,
          inputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        RegularTextInput(
          controller: _nipController,
          label: 'NIP',
          inputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          readOnly: true,
        ),
        const SizedBox(height: Dimens.dp16),
        ImageInput(
          label: S.of(context).profile_picture,
          hintText: S.of(context).recomended_resolution,
          onChange: _onImageChanged,
          initialImage: _image,
          imageNetwork: _networkImage,
          source: ImageSource.gallery,
          readOnly: widget.type == FormProfileType.viewOnly,
        ),
      ],
    );
  }

  Widget _buildCannotEditInformation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          '✹ ',
          style: TextStyle(
            color: StaticColors.red,
            fontSize: Dimens.dp16,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: Dimens.dp4),
            child: Text(S.of(context).cannot_update_profile_information),
          ),
        )
      ],
    );
  }

  Widget _buildButtonAction(ManipulateProfileState state) {
    if (isEdit) {
      return SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Dimens.dp16),
          height: 80,
          child: PrimaryButton(
            onPressed: state.status.isValidated
                ? () {
                    _bloc?.add(ManipulateProfileSubmitted());
                  }
                : null,
            child: Text(S.of(context).update_profile),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void _onImageChanged(File v) {
    if (isEdit) {
      setState(() {
        _image = v;
      });
      _bloc?.add(ManipulateProfileChangeAvatar(v));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telegramIdController.dispose();
    _addressController.dispose();
    _bankNameController.dispose();
    _bankNumberController.dispose();
    _nipController.dispose();
    super.dispose();
  }
}
