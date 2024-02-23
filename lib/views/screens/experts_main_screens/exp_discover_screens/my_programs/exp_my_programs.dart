import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/meal.dart';
import 'package:ifit/models/workout.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/my_programs/body/exp_created_program.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/my_programs/body/exp_deleted_program.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/my_programs/body/exp_favorites_program.dart';

// class ExpMyPrograms extends StatefulWidget {
//   final int initialSelectTab;
//   final Widget initialCurrentTab;
  
//   const ExpMyPrograms({super.key, 
//   required this.initialSelectTab, 
//   required this.initialCurrentTab});

//   @override
//   State<ExpMyPrograms> createState() => _ExpMyProgramsState();
// }

// class _ExpMyProgramsState extends State<ExpMyPrograms> {
//   late TabController tabController;
//   late Widget currentTab;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, initialIndex: widget.initialSelectTab, vsync: this);
//     currentTab = widget.initialCurrentTab;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             margin: const EdgeInsets.all(12),
//             height: 30,
//             width: 30,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(10)),
//             child: const Icon(
//               FluentSystemIcons.ic_fluent_chevron_left_filled,
//               size: 20,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         title: Text(
//           'My Programs',
//           style: Styles.headline20,
//         ),
        
//         bottom: TabBar(
//         controller: tabController,
//         tabs: const <Tab>[
//           Tab(text: 'Created'),
//           Tab(text: 'Deleted'),
//           Tab(text: 'Favorites'),
//         ],
//         labelColor: primary, // Customize the selected tab text color.
//         unselectedLabelColor: Colors.black, // Customize the unselected tab text color.
//         indicatorColor: primary,
//       ),
//       ),
//       body: TabBarView(
//         controller: tabController,
//         children: const <Widget>[
//           ExpCreatedProgramScreen(),
//           ExpDeletedProgramScreen(),
//           ExpFavoritesProgramScreen(),
//         ],
//       ),
      
//     );
//   }
// }


// class ExpCreatedProgram extends StatefulWidget {
//   const ExpCreatedProgram({super.key});

//   @override
//   State<ExpCreatedProgram> createState() => _ExpCreatedProgramState();
// }

// class _ExpCreatedProgramState extends State<ExpCreatedProgram> {
//   @override
//   Widget build(BuildContext context) {
//     return const ExpMyPrograms(initialSelectTab: 0, initialCurrentTab: ExpCreatedProgramScreen());
//   }
// }

class ExpProgramScreen extends StatefulWidget {
  const ExpProgramScreen({
    super.key,
    required this.initialSelectTab,
    required this.initialCurrentTab,
    required this.workoutMealList,
    required this.workoutPlanList,
  });

  final int initialSelectTab;
  final Widget initialCurrentTab;
  final List<WorkoutMeal> workoutMealList;
  final List<WorkoutPlan> workoutPlanList;

  @override
  State<ExpProgramScreen> createState() => _ExpProgramScreenState();
}

class _ExpProgramScreenState extends State<ExpProgramScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;
  late Widget currentTab;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, initialIndex: widget.initialSelectTab, vsync: this);
    currentTab = widget.initialCurrentTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
        title: Text(
          'My Programs',
          style: Styles.headline20,
        ),
        
        bottom: TabBar(
        controller: tabController,
        tabs: const <Tab>[
          Tab(text: 'Created'),
          Tab(text: 'Deleted'),
          Tab(text: 'Favorites'),
        ],
        labelColor: primary, // Customize the selected tab text color.
        unselectedLabelColor: Colors.black, // Customize the unselected tab text color.
        indicatorColor: primary,
      ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          ExpCreatedProgramScreen(
            workoutMealList: widget.workoutMealList,
            workoutPlanList: widget.workoutPlanList,
          ),
          ExpDeletedProgramScreen(
            workoutPlanList: widget.workoutPlanList,
            workoutMealList: widget.workoutMealList,
          ),
          ExpFavoritesProgramScreen(),
        ],
      ),
      
    );
  }
}


class ExpCreatedProgram extends StatelessWidget {
  const ExpCreatedProgram({
    super.key,
    required this.workoutPlanList,
    required this.workoutMealList,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;

  @override
  Widget build(BuildContext context) {
    return ExpProgramScreen(
      initialSelectTab: 0,
      initialCurrentTab: ExpCreatedProgramScreen(
        workoutMealList: workoutMealList,
        workoutPlanList: workoutPlanList,
      ),
      workoutMealList: workoutMealList,
      workoutPlanList: workoutPlanList,
    );
  }
}

class ExpDeletedProgram extends StatelessWidget {
  const ExpDeletedProgram({
    required this.workoutMealList,
    required this.workoutPlanList,
    super.key,
  });

  final List<WorkoutPlan> workoutPlanList;
  final List<WorkoutMeal> workoutMealList;


  @override
  Widget build(BuildContext context) {
    return ExpProgramScreen(
      initialSelectTab: 0,
      initialCurrentTab: ExpDeletedProgramScreen(
        workoutMealList: workoutMealList,
        workoutPlanList: workoutPlanList,
      ),
      workoutMealList: workoutMealList,
      workoutPlanList: workoutPlanList,
    );
  }
}

class ExpFavorites extends StatefulWidget {
  const ExpFavorites({super.key});

  @override
  State<ExpFavorites> createState() => _ExpFavoritesState();
}

class _ExpFavoritesState extends State<ExpFavorites> {
  @override
  Widget build(BuildContext context) {
    return ExpProgramScreen(
      initialSelectTab: 0,
      initialCurrentTab: ExpFavoritesProgramScreen(),
      workoutMealList: [],
      workoutPlanList: [],
    );
  }
}