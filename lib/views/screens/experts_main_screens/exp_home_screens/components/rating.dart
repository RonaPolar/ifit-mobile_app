import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/views/widgets/button/main_button.dart';

class ExpertRatingWidget extends StatelessWidget {
  const ExpertRatingWidget({
    required this.expertModel,
    super.key,
  });

  final ExpertModel expertModel;

  @override
  Widget build(BuildContext context) {

    double rating() {
      if (expertModel.ratingCount == 0) {
        return 0.0;
      } else {
        return expertModel.rating! / expertModel.ratingCount;
      }
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 0, 0, 72),
          borderRadius: BorderRadius.circular(20)),
      child: Stack(alignment: Alignment.center, children: [
        Image.asset(
          "assets/images/Dots.png",
          height: 120,
          width: double.maxFinite,
          fit: BoxFit.fitHeight,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Rating by Clients",
                    style: Styles.text15bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "You have a High Rating",
                    style: Styles.seeMore.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const Gap(12),
                  SizedBox(
                      width: 110,
                      height: 25,
                      child: MainButton(
                        title: "View More",
                        onPressed: () {
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //         const ExpProfileScreen()));
                        },
                        textStyle: Styles.seeMore.copyWith(
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        FluentSystemIcons.ic_fluent_star_filled,
                        size: 80,
                        color: Styles.bgColor,
                      ),
                      Text(rating().toStringAsFixed(2),
                        style: Styles.headline20
                            .copyWith(color: Styles.primaryColor),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
