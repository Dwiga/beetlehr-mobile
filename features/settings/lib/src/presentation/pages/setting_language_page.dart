import 'package:component/component.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';
import 'package:preferences/preferences.dart';

import '../../../settings.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({Key? key}) : super(key: key);

  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  late LanguageBloc _bloc;
  Country? _currentLanguage;

  @override
  void initState() {
    _bloc = BlocProvider.of<LanguageBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).select_language),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildActionButton(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      _currentLanguage ??= state.country;
      // final _currentLocale = Localizations.localeOf(context);
      // final _queryLanguage = CountryData.supportedCountry
      //     .where((lang) => lang.code == _currentLocale.languageCode);

      // if (_queryLanguage.isNotEmpty) {
      //   _currentLanguage = _queryLanguage.first;
      // }

      return _buildListLanguage(
        CountryData.supportedLanguageCountry,
        _currentLanguage,
      );
    });
  }

  Widget _buildListLanguage(List<Country> allCountry, Country? currentCountry) {
    return ListView.separated(
      itemBuilder: (_, i) {
        return ListTile(
          title: Text(allCountry[i].name),
          trailing: currentCountry?.code == allCountry[i].code
              ? Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                )
              : null,
          onTap: () {
            setState(() {
              _currentLanguage = allCountry[i];
            });
          },
        );
      },
      separatorBuilder: (_, __) {
        return const Divider(height: 1);
      },
      itemCount: allCountry.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _buildActionButton() {
    return SafeArea(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(Dimens.dp16),
        width: double.infinity,
        child: PrimaryButton(
          child: Text(S.of(context).apply),
          onPressed: (_currentLanguage != null)
              ? () {
                  _bloc.add(ChangeLanguageEvent(_currentLanguage!));
                  Navigator.of(context).pop();
                }
              : null,
        ),
      ),
    );
  }
}
