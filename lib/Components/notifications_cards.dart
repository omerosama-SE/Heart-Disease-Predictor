import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/models/notifications_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationCards extends StatefulWidget {
  NotificationCards({required this.notification, required this.onDelete});

  NotificationsModel notification;
  Function() onDelete;

  @override
  State<NotificationCards> createState() => _NotificationCardsState();
}

class _NotificationCardsState extends State<NotificationCards> {
  bool isRemoved = false;

  @override
  void initState() {
    super.initState();
    loadAppoitnmentState(widget.notification.id);
  }

  Future<void> loadAppoitnmentState(int id) async {
    final prefs = await SharedPreferences.getInstance();

    String isRemovedKey = 'removed_$id';

    setState(() {
      isRemoved = prefs.getBool(isRemovedKey) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //capture date and time parts from the message
    String str = widget.notification.content;

    RegExp dateExp = RegExp(r'date\s+(\d{1,2}\s+\w+\s+\d{4})');
    RegExp timeExp = RegExp(r'time\s+(\d{1,2}:\d{2}\s?[AP]M)');

    String? date = dateExp.firstMatch(str)?.group(1);
    String? time = timeExp.firstMatch(str)?.group(1);

//convert the date format
    String formattedDate = '';
    if (date != null) {
      DateFormat inputFormat = DateFormat('d MMMM yyyy');
      DateTime dateTime = inputFormat.parse(date);

      DateFormat outputFormat = DateFormat('EEEE d/M');
      formattedDate = outputFormat.format(dateTime);
    } else {}

    return Container(
      width: 370,
      height: widget.notification.content.contains('Sorry')
          ? 115
          : 100, //Variable Length according to the message (Accepet or Cancel) 100 for accept & 115 for cancel
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // More transparent shadow
            spreadRadius: 2, // Reduced spread radius
            blurRadius: 4, // Reduced blur radius
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(flex: 1),
                            Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: widget.notification.content
                                            .contains('Sorry')
                                        ? Colors.red
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(5))),
                          ],
                        ),
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset('assets/images/bell.png')),
                      ],
                    )),
              ),
            ],
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 1),
                Row(
                  children: [
                    Text(
                      'Dr. ${widget.notification.docName.split(" ").map((str) => str[0].toUpperCase() + str.substring(1)).join(" ")}',
                      style: TextStyle(
                          // color: Color(0xffD7E8F0),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Myriad'),
                    ),
                    Spacer(flex: 6),
                    GestureDetector(
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: widget.notification.phone,
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('Cannot Lanch This URL');
                        }
                      }, //call the doctor function
                      child: Icon(
                        Icons.call,
                        size: 20,
                        // color: Color(0xff00466D),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // isRemoved = true;
                          widget.onDelete();
                        });
                        saveAppointmentsState(
                            widget.notification.id, isRemoved);
                      }, //remove the notification
                      child: Icon(
                        Icons.delete,
                        size: 20,
                        // color: Color(0xff00466D),
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
                SizedBox(height: 5),
                widget.notification.content.contains('Sorry')
                    ? Text(
                        'Sorry, Your appointment $formattedDate from $time at ${widget.notification.location} was canceled due to too many appointments',
                        style: TextStyle(fontSize: 15),
                      )
                    : Text(
                        'Confirms Your Appointment $formattedDate from $time at ${widget.notification.location}',
                        style: TextStyle(fontSize: 15),
                      ),
                Spacer(flex: 1),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> saveAppointmentsState(int id, bool removed) async {
    final prefs = await SharedPreferences.getInstance();

    String isRemovedKey = 'removed_$id';

    prefs.setBool(isRemovedKey, removed);
  }
}
