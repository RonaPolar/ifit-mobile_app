import 'dart:convert';
import 'dart:math';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:ifit/common/constant/string.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/widgets/search.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/expert_list.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/new_arrival.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/components/popular.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/my_program/my_program.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  TextEditingController txtSearch = TextEditingController();

  List<Expert> discoverExperts = [];
  List<Workout> popularWorkout = [];
  List<Meal> popularMeal = [];

  @override
  void initState() {
    super.initState();
    getStaticData();
  }

  Future<void> getStaticData() async {
    final String expert = await rootBundle.loadString(JsonFile.expert);
    final String meal = await rootBundle.loadString(JsonFile.meal);
    final String workout = await rootBundle.loadString(JsonFile.workout);

    setState(() {
      discoverExperts = (jsonDecode(expert)["expert"] as List).map((e) => Expert.fromJson(e)).toList();
      popularWorkout = (jsonDecode(workout)["popularWorkout"] as List).map((e) => Workout.fromJson(e)).toList();
      popularMeal = (jsonDecode(meal)["popularMeal"] as List).map((e) => Meal.fromJson(e)).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    List<dynamic> combinedList = [...popularWorkout, ...popularMeal];

    combinedList.shuffle(Random());

    return Scaffold(
      backgroundColor: Styles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //   builder: (context) => const HomeNavBar()));
            },
            child: Container(
              margin: const EdgeInsets.all(12),
                height: 30,
                width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                FluentSystemIcons.ic_fluent_chevron_left_filled,
                size: 20,
                color: Colors.black,
              ),
            ),
        ),
        title: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
          child: SearchContainer(
            controller: txtSearch, hintText: "Search",
          )
        ),
        actions: [
          InkWell(
            onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                builder: (context) => const OngoingPrograms()));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal:15, vertical: 10),
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(FluentSystemIcons.ic_fluent_person_regular,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:15, right:15, left:15),
                child: Text(
                    "Daily Discover",
                    style: Styles.title
                  ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 3
                    )
                  ),
                  child: Column(
                    children: [
                      NewArrivalWidget(combinedList: combinedList),
                      const Gap(10),
                      PopularWidget(combinedList: combinedList),
                    ],
                  ),
                ),
              ),
              const Gap(15),
              ExpertListWidget(
                discoverExperts: discoverExperts,
                combinedList: combinedList,
              ),
              const Gap(10)
            ],//main Children
          ),
        ],

      ),
    );
  }
}