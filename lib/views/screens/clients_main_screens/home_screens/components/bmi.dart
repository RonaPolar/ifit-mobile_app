import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/common/widgets/main_button.dart';
import 'package:ifit/views/screens/clients_main_screens/main_bottom_bar.dart';

class BMIWidget extends StatelessWidget {
  const BMIWidget({
    required this.bmi,
    super.key,
  });

  final double bmi;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BMI (Body Mass Index)",
                    style: Styles.text15bold.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "You have a normal weight",
                    style: Styles.seeMore.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const Gap(9),
                  SizedBox(
                    width: 110,
                    height: 30,
                    child: MainButton(
                      title: "View More",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProfileNavBar()));
                      },
                      textStyle: Styles.seeMore.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {},
                    ),
                    startDegreeOffset: 250,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  //BMI pIE cHART
  List<PieChartSectionData> showingSections() {
    return List.generate(
      2,
          (i) {
        switch (i) {
          case 0:
            return PieChartSectionData(
                color: primary,
                value: bmi,
                title: '',
                radius: 45,
                titlePositionPercentageOffset: 0.55,
                badgeWidget: Text(
                  bmi.toStringAsFixed(1), // Display BMI with one decimal place
                  style: Styles.text12.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ));
          case 1:
            return PieChartSectionData(
              color: Colors.white,
              value: 75,
              title: '',
              radius: 40,
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }
}
