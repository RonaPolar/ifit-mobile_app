import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:ifit/common/utils/app_styles.dart';
import 'package:ifit/models/notification.dart';
import 'package:ifit/service/Expert.dart';
import 'package:ifit/views/widgets/body/stream.dart';
import 'package:ifit/views/widgets/more_icon.dart';
import 'package:provider/provider.dart';

class ExpNotifications extends StatefulWidget {
  const ExpNotifications({
    required this.id,
    this.title = "Notification",
    super.key,
  });

  final String id;
  final String? title;

  @override
  State<ExpNotifications> createState() => _ExpNotificationsState();
}

class _ExpNotificationsState extends State<ExpNotifications> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context, listen: false);
      expertProvider.updateNotifStream(uid: widget.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

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
        title: Text(widget.title!,
        style: Styles.headline20,
        ),
      ),
      body: StreamWrapper<List<NotifModel>>(
        stream: expertProvider.notifStream,
        child: (data) {
          final List<NotifModel> notifList = data!;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            itemCount: notifList.length,
            itemBuilder: (context, index) {
              var nObj = notifList[index];
              return NotificationRow(
                id: widget.id,
                nObj: nObj,
              );
            },
            separatorBuilder: (context, index) {
                return Divider(color: Colors.grey.withOpacity(0.5), height: 1,
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
    final DateTime now = DateTime.now();
    final ExpertProvider expertProvider = Provider.of<ExpertProvider>(context);

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
            options: ['Remove'],
            iconData: FluentSystemIcons.ic_fluent_more_vertical_filled,
            onTap: (val) async {
              await expertProvider.deleteNotif(
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