import 'package:flutter/material.dart';
import 'package:ifit/models/client.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/screens/clients_main_screens/discover_screens/discover.dart';
import 'package:ifit/views/screens/clients_main_screens/home_screens/home.dart';
import 'package:ifit/views/screens/clients_main_screens/profile_screens/profile.dart';
import 'package:ifit/views/screens/clients_main_screens/program_tracker_screens/program_tracker.dart';
import 'package:provider/provider.dart';

class ClientAuthWrapper extends StatefulWidget {
  const ClientAuthWrapper({
    required this.uid,
    required this.index,
    super.key,
  });

  final String uid;
  final int index;

  @override
  State<ClientAuthWrapper> createState() => _ClientAuthWrapperState();
}

class _ClientAuthWrapperState extends State<ClientAuthWrapper> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClientProvider client = Provider.of<ClientProvider>(context, listen: false);
      client.updateClientStream(uid: widget.uid);
    });
  }


  List<Widget> bodyList(ClientModel clientModel) {
    return [
      HomeScreen(clientModel: clientModel),
      DiscoverScreen(),
      ProgramTrackerScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ClientProvider client = Provider.of<ClientProvider>(context);


    return StreamBuilder<ClientModel>(
      stream: client.clientStream,
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
