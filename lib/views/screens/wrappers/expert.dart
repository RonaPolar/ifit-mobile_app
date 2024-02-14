import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/service/Expert.dart';
import 'package:provider/provider.dart';

class ExpertAuthWrapper extends StatefulWidget {
  const ExpertAuthWrapper({
    required this.uid,
    required this.child,
    super.key,
  });

  final String uid;
  final Widget child;

  @override
  State<ExpertAuthWrapper> createState() => _ExpertAuthWrapperState();
}

class _ExpertAuthWrapperState extends State<ExpertAuthWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      print(widget.uid);
      expertProvider.updateExpertStream(uid: widget.uid);

    });
  }

  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

    return StreamBuilder<ExpertModel>(
      stream: expertProvider.expertStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          return widget.child;
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
