import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../auth.dart';
import 'sections/auth_header_section.dart';

/// Forget Password page
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late ResetPassBloc _bloc;
  String? _companyLogo = '';

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _bloc = GetIt.I<ResetPassBloc>();
    _emailController.addListener(() => _onEmailChanged(_emailController.text));
    _companyLogo = GetIt.I<GlobalConfiguration>().getValue('company_logo');
    super.initState();
  }

  void _onEmailChanged(String v) {
    _bloc.add(ResetPassEmailChanged(email: v));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).recover_password),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
          children: [_buildBody()],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<ResetPassBloc, ResetPassState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          IndicatorsUtils.showErrorSnackBar(context, state.failure?.message);
        } else if (state.status.isSubmissionInProgress) {
          IndicatorsUtils.showLoadingSnackBar(context);
        } else if (state.status.isSubmissionSuccess) {
          if (mounted) {
            IndicatorsUtils.hideCurrentSnackBar();
          }
        }
      },
      builder: (context, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          return _buildSuccessResetPassword();
        }
        return _buildFormResetPassword(state);
      },
    );
  }

  Widget _buildFormResetPassword(ResetPassState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthHeaderSection(
          icon: AppIcons.lockReset,
          title: S.of(context).recover_password,
          description: S.of(context).message_recover_password,
          companyLogo: _companyLogo.toString(),
        ),
        const SizedBox(height: Dimens.dp32),
        RegularTextInput(
          hintText: S.of(context).hint_input_email,
          inputType: TextInputType.emailAddress,
          controller: _emailController,
          errorText: state.email.invalid
              ? S.of(context).invalid_format_input('Email')
              : null,
        ),
        const SizedBox(height: Dimens.dp24),
        PrimaryButton(
          onPressed:
              state.status.isValidated && !state.status.isSubmissionInProgress
                  ? () {
                      FocusScope.of(context).unfocus();
                      _bloc.add(
                        ResetPassSubmitted(),
                      );
                    }
                  : null,
          child: Text(S.of(context).send_reset_link),
        ),
      ],
    );
  }

  Widget _buildSuccessResetPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthHeaderSection(
          icon: AppIcons.minutemailer,
          title: S.of(context).success_recover_password,
          description: S.of(context).message_success_recover_password,
          companyLogo: _companyLogo,
        ),
        const SizedBox(height: Dimens.dp24),
        PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).back_to_login),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}
