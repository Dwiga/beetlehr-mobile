import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '404 Page Not Found',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
