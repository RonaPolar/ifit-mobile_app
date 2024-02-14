import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_discover_screens/exp_discover.dart';
import 'package:ifit/views/screens/Experts_main_screens/exp_home_screens/exp_home.dart';
import 'package:provider/provider.dart';

import '../Experts_main_screens/exp_program_screens/exp_program.dart';
import '../experts_main_screens/exp_profile_screens/exp_profile.dart';

class ExpertAuthWrapper extends StatefulWidget {
  const ExpertAuthWrapper({
    required this.uid,
    required this.index,
    super.key,
  });

  final String uid;
  final int index;

  @override
  State<ExpertAuthWrapper> createState() => _ExpertAuthWrapperState();
}

class _ExpertAuthWrapperState extends State<ExpertAuthWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      expertProvider.updateExpertStream(uid: widget.uid);

    });
  }



  List<Widget> bodyList(ExpertModel expertModel) {
    return [
      ExpHomeScreen(expertModel: expertModel),
      ExpDiscoverScreen(),
      ExpProgramScreen(),
      ExpProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return StreamBuilder<ExpertModel>(
      stream: expertProvider.expertStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final data = snapshot.data!;

          return bodyList(data)[widget.index];
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong: ${snapshot.error}"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
