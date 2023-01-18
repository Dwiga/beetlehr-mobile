import 'package:component/component.dart';
import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';
import 'package:settings/settings.dart';

import '../../../../auth.dart';
import '../sections/sections.dart';

/// General Login Page
class LoginWithEmailPage extends StatefulWidget {
  const LoginWithEmailPage({Key? key}) : super(key: key);

  @override
  _LoginWithEmailPageState createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  late LoginBloc _bloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _defaultUrl = '';
  String? _companyLogo = '';
  bool _urlEditable = false;

  @override
  void initState() {
    _bloc = GetIt.I<LoginBloc>();
    _defaultUrl = GetIt.I<GlobalConfiguration>().getValue('base_url');
    _urlEditable = GetIt.I<GlobalConfiguration>().getValue('url_editable');
    _companyLogo = GetIt.I<GlobalConfiguration>().getValue('company_logo');

    _addListeners();
    super.initState();
  }

  void _addListeners() {
    _emailController.addListener(() => _onEmailChanged(_emailController.text));
    _passwordController
        .addListener(() => _onPasswordChanged(_passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<Failure, Uri?>>(
      future: GetIt.I<GetBaseUrlUseCase>().call(NoParams()),
      builder: (context, snapshot) {
        return BlocProvider(
          create: (_) => _bloc,
          child:
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              IndicatorsUtils.showErrorSnackBar(
                  context, state.failure?.message);
            } else if (state.status.isSubmissionInProgress) {
              IndicatorsUtils.showLoadingSnackBar(context);
            } else if (state.status.isSubmissionSuccess) {
              context.read<AuthBloc>().add(AuthLoginEvent(state.user!));
              if (mounted) {
                IndicatorsUtils.hideCurrentSnackBar();
              }
            }
          }, builder: (context, state) {
            return Scaffold(
              body: _buildBody(state, snapshot.data),
              bottomNavigationBar: _buildButton(state),
            );
          }),
        );
      },
    );
  }

  Widget _buildUrl(Either<Failure, Uri?>? data) {
    final url = data?.foldRight(null, (r, previous) => r);

    return Text(
      url != null ? url.host : _defaultUrl.toString(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBody(LoginState state, Either<Failure, Uri?>? data) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Image.asset(
              _companyLogo.toString(),
              height: 150,
            ),
            const SizedBox(height: Dimens.dp14),
            Image.asset(
              'assets/images/beetlehr_text.png',
              height: Dimens.dp20,
            ),
            const SizedBox(height: Dimens.dp36),
            RegularText(
              S.of(context).connected_to_domain,
              align: TextAlign.center,
            ),
            const SizedBox(height: Dimens.dp16),
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.dp10),
              child: Container(
                width: Dimens.dp200,
                height: Dimens.dp40,
                color: StaticColors.black5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      margin:
                          EdgeInsets.only(left: _urlEditable ? Dimens.dp16 : 0),
                      child: Center(child: _buildUrl(data)),
                    ),
                    _urlEditable
                        ? IconButton(
                            padding: const EdgeInsets.all(Dimens.dp2),
                            icon: Icon(
                              Icons.edit,
                              size: Dimens.dp16,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/setting-url').then(
                                (value) => setState(
                                  () {
                                    _buildBody(state, data);
                                  },
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.dp24),
        _buildLoginPhoneForm(state),
      ],
    );
  }

  Widget _buildButton(LoginState state) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(Dimens.dp16),
        child: PrimaryButton(
          child: Text(S.of(context).login),
          onPressed:
              state.status.isValidated && !state.status.isSubmissionInProgress
                  ? () {
                      _bloc.add(
                        const LoginSubmitted(),
                      );
                      FocusScope.of(context).unfocus();
                    }
                  : null,
        ),
      ),
    );
  }

  Widget _buildLoginPhoneForm(LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RegularTextInput(
          controller: _emailController,
          inputType: TextInputType.emailAddress,
          hintText: S.of(context).hint_input_email,
          errorText: state.email.invalid
              ? S.of(context).invalid_format_input('Email')
              : null,
        ),
        const SizedBox(height: Dimens.dp16),
        PasswordTextInput(
          controller: _passwordController,
          hintText: S.of(context).hint_input_password,
          errorText: state.password.invalid
              ? S.of(context).minimum_input('Password', '8')
              : null,
        ),
        const SizedBox(height: Dimens.dp24),
        const ForgotPasswordSection(),
        const SizedBox(height: Dimens.dp24),
      ],
    );
  }

  void _onEmailChanged(String v) {
    _bloc.add(LoginEmailChanged(v));
  }

  void _onPasswordChanged(String v) {
    _bloc.add(LoginPasswordChanged(v));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    if (mounted) {
      IndicatorsUtils.hideCurrentSnackBar();
    }
    super.dispose();
  }
}
