import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class RatingAndReviewCard extends StatelessWidget {
  const RatingAndReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.dp16, right: Dimens.dp16, bottom: Dimens.dp16),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          UserTile(
            nameUser: 'Joko',
            subjectUser: "HR Chief",
            placementUser: "Rumah Sakit Hasan Sadikin",
            colorDot: Colors.grey,
            colorPlacement: Colors.grey,
            colorSubject: Colors.grey,
            avatarUser: Image.asset(
              'assets/images/employee.jpg',
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            additionalInfo: _buildRatingStar(),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 45, top: Dimens.dp4, bottom: Dimens.dp16),
            child: Container(
              width: MediaQuery.of(context).size.width - 45,
              decoration: BoxDecoration(
                color: StaticColors.lightGrey,
                borderRadius: BorderRadius.circular(Dimens.dp4),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.fromLTRB(Dimens.dp12, Dimens.dp8, 0, Dimens.dp8),
                child: RegularText(
                  'Pekerjaan bagus, hanya saja ketika bertemu jarang menyapa',
                  style: TextStyle(
                      fontSize: Dimens.dp12, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: StaticColors.lightGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStar() {
    return Row(
      children: const [
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: Dimens.dp12,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: Dimens.dp12,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: Dimens.dp12,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: Dimens.dp12,
        ),
        Icon(
          Icons.star_outlined,
          color: Colors.yellow,
          size: Dimens.dp12,
        ),
      ],
    );
  }
}
