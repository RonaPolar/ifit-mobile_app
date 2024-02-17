import 'package:flutter/material.dart';
import 'package:ifit/models/expert.dart';
import 'package:ifit/service/client.dart';
import 'package:provider/provider.dart';

class ExpertListWrapper extends StatefulWidget {
  const ExpertListWrapper({
    required this.child,
    super.key,
  });

  final Widget Function(List<ExpertModel> expertList) child;

  @override
  State<ExpertListWrapper> createState() => _ExpertListWrapperState();
}

class _ExpertListWrapperState extends State<ExpertListWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
      clientProvider.updateExpertListStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    return StreamBuilder<List<ExpertModel>>(
      stream: clientProvider.expertListStream,
      builder: (context, snapshot) {

        if (snapshot.hasData) {
          final data = snapshot.data!;

          return widget.child(data);
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
