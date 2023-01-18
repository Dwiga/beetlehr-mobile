import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:settings/settings.dart';
import 'package:l10n/l10n.dart';
import 'package:settings/src/presentation/pages/setting_url/sections/sections.dart';

class SettingUrlPage extends StatefulWidget {
  const SettingUrlPage({Key? key, this.onTap}) : super(key: key);

  final ValueChanged<String>? onTap;

  @override
  _SettingUrlPageState createState() => _SettingUrlPageState();
}

class _SettingUrlPageState extends State<SettingUrlPage>
    with SingleTickerProviderStateMixin {
  final BaseUrlSchema _schema = BaseUrlSchema.https;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: Dimens.dp32),
      children: [
        const SizedBox(height: Dimens.dp48),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.dp24),
          child: Image.asset(
            'assets/images/url_setup.png',
            width: Dimens.width(context) * 0.6,
          ),
        ),
        const SizedBox(height: Dimens.dp32),
        const Center(child: TitleText('Installation URL')),
        const SizedBox(height: Dimens.dp8),
        Center(child: Text(S.of(context).enter_the_url)),
        const SizedBox(height: Dimens.dp16),
        DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TabBar(
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: 'Qerja Cloud'),
                  Tab(text: 'Custom Domain'),
                ],
              ),
              Container(
                height: 400, //height of TabBarView
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: TabBarView(
                  children: <Widget>[
                    Center(
                      child: ChangeUrlBoxSection(
                        onChanged: (value) => setState(() {
                          if (widget.onTap != null) {
                            widget.onTap!(value);
                          }
                        }),
                      ),
                    ),
                    Center(
                      child: SetUrlDropDownSection(
                        value: _schema,
                        onChanged: (value) => setState(() {
                          if (widget.onTap != null) {
                            widget.onTap!(value);
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
