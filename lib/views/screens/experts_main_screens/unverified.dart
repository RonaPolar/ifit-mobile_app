import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/service/auth.dart';
import 'package:ifit/views/widgets/button/main_button.dart';
import 'package:provider/provider.dart';

class UnverifiedScreen extends StatelessWidget {
  const UnverifiedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/4thSlide.png",
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 24.0),
              Text("Admin still reviewing your application",
                textAlign: TextAlign.center,
                style: Styles.title,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: MainButton(
                  title: "Change account",
                  onPressed: () async {
                    await auth.changeAccount().then((value) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
