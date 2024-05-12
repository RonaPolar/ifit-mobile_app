import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/screens/wrappers/client.dart';

class BottomBar extends StatelessWidget {
  final IconData icon;
  final IconData selectIcon;
  final VoidCallback onTap;
  final bool isActive;

  const BottomBar({
    Key? key,
    required this.icon,
    required this.selectIcon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            isActive ? selectIcon : icon,
            color: isActive ? primary : Colors.black,
          ),
          Visibility(
            visible: isActive,
            child: Container(  //the circle under the icons of bottom navbar when onTapped
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MainBottomBar extends StatefulWidget {

  const MainBottomBar({
    Key? key,
  }) : super(key: key);


  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int selectTab = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final String uid = snapshot.data!.uid;
              return ClientAuthWrapper(
                uid: uid,
                index: selectTab,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong: ${snapshot.error}"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
        bottomNavigationBar: BottomAppBar(  //the line above the bottombar
          color: Styles.bgColor,
          elevation: 100,
          shadowColor: Colors.black12,
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                BottomBar(
                  icon: FluentSystemIcons.ic_fluent_home_regular,
                  selectIcon: FluentSystemIcons.ic_fluent_home_filled,
                  isActive: selectTab == 0,
                  onTap: () {
                    setState(() {
                      selectTab = 0;
                    });
                  },
                ),
                BottomBar(
                  icon: FluentSystemIcons.ic_fluent_grid_regular,
                  selectIcon: FluentSystemIcons.ic_fluent_grid_filled,
                  isActive: selectTab == 1,
                  onTap: () {
                    setState(() {
                      selectTab = 1;
                    });
                  },
                ),
                BottomBar(
                  icon: FluentSystemIcons.ic_fluent_activity_regular,
                  selectIcon: FluentSystemIcons.ic_fluent_activity_filled,
                  isActive: selectTab == 2,
                  onTap: () {
                    setState(() {
                      selectTab = 2;
                    });
                  },
                ),
                BottomBar(
                  icon: FluentSystemIcons.ic_fluent_person_regular,
                  selectIcon: FluentSystemIcons.ic_fluent_person_filled,
                  isActive: selectTab == 3,
                  onTap: () {
                    setState(() {
                      selectTab = 3;
                    });
                  },
                ),
              ],
            ),
          ),
      ),
    );
  }
}
