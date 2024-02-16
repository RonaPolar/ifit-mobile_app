// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:ifit/common/utils/api_connect.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/firebase_options.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/account_login_reg/register/client_registration/register_part3.dart';
import 'package:ifit/views/screens/account_login_reg/register/expert_registration/expert_registration1.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/home.dart';
import 'package:ifit/views/screens/clients_main_screens/main_bottom_bar.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/meal_screens/meal_tracker.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_schedule/program_schedule.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/workout_screens/workout_tracker.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_bottom_bar.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_program_screens/create_program_screens/create_meal.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_program_screens/create_program_screens/create_work.dart';
import 'package:ifit/views/screens/experts_main_screens/exp_program_screens/create_program_screens/create_work_next.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/screens/wrappers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifit/views/screens/welcome/onboarding_screen.dart';
import 'package:ifit/views/screens/account_login_reg/register/register.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final WidgetsBinding widgetsBinding = WidgetsBinding.instance; // Define and initialize widgetsBinding
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SharedPreferences prefs = await SharedPreferences.getInstance(); //dependency to check if just installed
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  Widget homeScreen;
  Get.put(ApiConnect());

  if (isFirstTime) {
    //condition to when the OnboardingScreen shows
    homeScreen = const OnboardingScreen();
    await prefs.setBool('isFirstTime', false);
  } else {
    homeScreen = const Register(); //Registration
  }
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp(homeScreen: homeScreen));
}

class MyApp extends StatefulWidget {
  final Widget? homeScreen;

  const MyApp({Key? key, this.homeScreen}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // whenever initialization is completed, remove the splash screen:
    Future.delayed(const Duration(seconds: 2))
        .then((value) => {FlutterNativeSplash.remove()});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
        ChangeNotifierProvider<ExpertProvider>(create: (_) => ExpertProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primary,
        ),
        title: 'I-Fit',

        // home: const CreateWorkout(), //for testing
        home: widget.homeScreen //either Onboarding or Register Screen
      ),
    );
  }
}
