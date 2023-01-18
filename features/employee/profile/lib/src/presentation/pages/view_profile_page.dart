import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../../profile.dart';

class ViewProfilePage extends StatefulWidget {
  final ProfileEntity profile;

  const ViewProfilePage({Key? key, required this.profile}) : super(key: key);
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ManipulateProfileBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).my_profile),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, '/profile/edit', arguments: {
                  'profile': widget.profile,
                });
              },
            )
          ],
        ),
        body: FormProfilePage(
          initialData: widget.profile,
          type: FormProfileType.viewOnly,
        ),
      ),
    );
  }
}
