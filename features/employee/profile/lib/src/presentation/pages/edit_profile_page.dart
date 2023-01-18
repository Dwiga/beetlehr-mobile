import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../profile.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileEntity profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ManipulateProfileBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(S.of(context).edit_profile),
        ),
        body: BlocListener<ManipulateProfileBloc, ManipulateProfileState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              IndicatorsUtils.showErrorSnackBar(
                  context, state.failure?.message);
            } else if (state.status.isSubmissionInProgress) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state.status.isSubmissionSuccess) {
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
              Future.delayed(const Duration(milliseconds: 100)).then((_) {
                Navigator.of(context).pop(true);
                Navigator.of(context).pop(true);
              });
            }
          },
          child: FormProfilePage(
            initialData: widget.profile,
            type: FormProfileType.edit,
          ),
        ),
      ),
    );
  }
}
