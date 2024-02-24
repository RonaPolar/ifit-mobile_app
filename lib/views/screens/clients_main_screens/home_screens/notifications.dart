import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/notification.dart';
import 'package:ifit/service/client.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/more_icon.dart';
import 'package:provider/provider.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    required this.id,
    super.key,
  });

  final String id;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List notificationArr = [
    {"image": "assets/images/meal/nigiri.png", "title": "Hey, it’s time for lunch", "time": "About 1 minutes ago"},
    {"image": "assets/icons/Lower-Weights.png", "title": "Don’t miss your Lowerbody Weights", "time": "About 3 hours ago"},
    {"image": "assets/images/meal/salad.png", "title": "Hey, let’s add some meals for your dinner", "time": "About 3 hours ago"},
    {"image": "assets/icons/workout-pic.png", "title": "Congratulations, You have finished Full Bo...", "time": "29 May"},
    {"image": "assets/images/meal/pancake.png", "title": "Hey, it’s time for snack", "time": "8 April"},
    {"image": "assets/icons/Ab-workout.png", "title": "Ups, You have missed your Ab Workout", "time": "8 April"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ClientProvider clientProvider = Provider.of<ClientProvider>(context, listen: false);
        clientProvider.updateNotifStream(uid: widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    return Scaffold(
      backgroundColor: Styles.bgColor,
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
          title: Text('Notification',
          style: Styles.headline20,
        ),
        // actions: const [
        //    MoreIcon(options: ['Today','This Week','This Month']
        //   ),
        // ],
      ),
      body: StreamWrapper<List<NotifModel>>(
        stream: clientProvider.notifStream,
        child: (data) {
          final List<NotifModel> notifList = data!;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            itemCount: notifList.length,
            itemBuilder: (context, index) {
              var nObj = notifList[index];
              return NotificationRow(
                nObj: nObj,
                id: widget.id,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              );
           },
          );
        }
      ),
    );
  }
}

class NotificationRow extends StatelessWidget {
  final NotifModel nObj;
  final String id;

  const NotificationRow({
    super.key,
    required this.nObj,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final ClientProvider clientProvider = Provider.of<ClientProvider>(context);

    final DateTime now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(nObj.photoUrl,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nObj.title,
                style: Styles.text12.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("About ${now.difference(nObj.dateCreated).inMinutes} minutes",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          )),
          MoreIcon(
            options: const ['Remove'],
            iconData: FluentSystemIcons.ic_fluent_more_vertical_filled,
            onTap: (val) async {
              await clientProvider.deleteNotif(
                id: id,
                notifId: nObj.id,
              ).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Deleted!")));
              });
            },
          )
        ],
      ),
    );
  }
}