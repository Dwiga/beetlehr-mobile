import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

enum AppMenuCardType { add, remove, disabled, none }

class AppMenuCard extends StatelessWidget {
  final String imageUrl;
  final AppMenuCardType? type;
  final String title;
  final VoidCallback? onTap;

  const AppMenuCard(
      {Key? key,
      this.onTap,
      required this.imageUrl,
      this.type = AppMenuCardType.none,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.dp8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildIcon(context),
          const SizedBox(height: Dimens.dp8),
          SmallText(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLine: 2,
            align: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return SizedBox(
      width: 54,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.network(
                imageUrl,
                width: Dimens.dp48,
                height: Dimens.dp48,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: Dimens.dp48,
                    width: Dimens.dp48,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(alignment: Alignment.topRight, child: _buildIndicator(context)),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    if (type == AppMenuCardType.add) {
      return _buildIconIndicator(
        color: StaticColors.green,
        icon: Icons.add,
      );
    } else if (type == AppMenuCardType.remove) {
      return _buildIconIndicator(
        color: StaticColors.red,
        icon: Icons.remove,
      );
    } else if (type == AppMenuCardType.disabled) {
      return _buildIconIndicator(
        color: Theme.of(context).disabledColor,
        icon: Icons.add,
      );
    } else {
      return const SizedBox(height: Dimens.dp16, width: Dimens.dp16);
    }
  }

  Widget _buildIconIndicator({required IconData icon, required Color color}) {
    return Container(
      width: Dimens.dp16,
      height: Dimens.dp16,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white)),
      child: Icon(icon, color: Colors.white, size: Dimens.dp14),
    );
  }
}
