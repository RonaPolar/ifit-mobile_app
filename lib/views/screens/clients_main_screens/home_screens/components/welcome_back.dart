import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/notifications.dart';

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back,',
              style: Styles.text15normal,
            ),
            Text(name,
              style: Styles.headline20,
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NotificationScreen()));
            },
            icon: const Icon(FluentSystemIcons.ic_fluent_alert_regular,
          ),
        )
      ],
    );
  }
}
