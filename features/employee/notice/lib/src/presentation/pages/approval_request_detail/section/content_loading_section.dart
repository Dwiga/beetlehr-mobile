import 'package:component/component.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: [
        const Skeleton(
          width: double.infinity,
          height: Dimens.dp300,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.dp16),
          child: Column(
            children: const [
              Skeleton(
                width: double.infinity,
                height: 44,
              ),
              SizedBox(height: Dimens.dp16),
              Skeleton(
                width: double.infinity,
                height: 64,
              ),
            ],
          ),
        )
      ],
    );
  }
}
