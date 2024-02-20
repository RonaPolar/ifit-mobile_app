//Nutrition Pie Chart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ifit/models/meal.dart';

class MealPieChart extends StatefulWidget {
  const MealPieChart({
    required this.workoutMealList,
    super.key,
  });

  final List<WorkoutMeal> workoutMealList;

  @override
  State<MealPieChart> createState() => _MealPieChartState();
}

class _MealPieChartState extends State<MealPieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.maxFinite,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 0,
          sections: widget.workoutMealList.isEmpty ? [] : showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {

    final List<WorkoutMeal> workoutMeal = widget.workoutMealList;
    double calories = 0;
    double protein = 0;
    double fats = 0;
    double sugar = 0;

    for (WorkoutMeal data in workoutMeal) {
      calories += double.parse(data.calories);
      protein += double.parse(data.protein);
      fats += double.parse(data.fats);
      sugar += double.parse(data.sugar);
    }

    double total = calories + protein + fats + sugar;

    String caloriesPercentage = ((calories / total) * 100).toStringAsFixed(2);
    String proteinPercentage = ((protein / total) * 100).toStringAsFixed(2);
    String fatsPercentage = ((fats / total) * 100).toStringAsFixed(2);
    String sugarPercentage = ((sugar / total) * 100).toStringAsFixed(2);

    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 70.0 : 50.0;
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 2),
      ];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue.shade400,
            value: double.parse(sugarPercentage),
            title: "$sugarPercentage%",
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/sugar_pie.png',
              size: widgetSize,
              borderColor: Colors.black
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow.shade700,
            value: double.parse(fatsPercentage),
            title: '$fatsPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/fat_pie.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.orange.shade800,
            value: double.parse(caloriesPercentage),
            title: '$caloriesPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/calories_pie.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.red.shade600,
            value: double.parse(sugarPercentage),
            title: '$sugarPercentage%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/proteins_pie.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.imageAsset, {
    required this.size,
    required this.borderColor,
  });
  final String imageAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Image.asset(
          imageAsset,
        ),
      ),
    );
  }
}