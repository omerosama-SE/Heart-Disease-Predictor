import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heart_disease_prediction/Components/notifications_cards.dart';
import 'package:heart_disease_prediction/Services/AppoitnmentService.dart';
import 'package:heart_disease_prediction/models/notifications_model.dart';
import 'package:intl/intl.dart';

class ViewNotificationsPage extends StatefulWidget {
  const ViewNotificationsPage({super.key});

  @override
  State<ViewNotificationsPage> createState() => _ViewNotificationsPageState();
}

class _ViewNotificationsPageState extends State<ViewNotificationsPage> {
  bool isLoading = true;
  List<NotificationsModel> notificationsList = [];
  final service = AppoitnmentsService(Dio());
  //loading inidcator
  OverlayEntry? _overlayEntry;

  void _showLoadingIndicator() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.3),
            child: Column(children: [
              Spacer(flex: 1),
              CircularProgressIndicator(color: Color(0xff00466D)),
              Spacer(flex: 1),
            ])),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _hideLoadingIndicator() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoadingIndicator();
      fetchNotifications();
    });
  }

  void fetchNotifications() async {
    final fetchedNotifications = await service.getNotifications();
    if (_overlayEntry != null) {
      _hideLoadingIndicator();
    }
    setState(() {
      notificationsList = fetchedNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F4F7),
      appBar: AppBar(
        backgroundColor: Color(0xffD7E8F0),
        toolbarHeight: 50,
        title: Column(
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontFamily: 'Myriad', fontSize: 22),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Expanded(
            child: ListView.separated(
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                return NotificationCards(
                  notification: notificationsList[index],
                  onDelete: () {
                    setState(() {
                      notificationsList.removeAt(index);
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 5);
              },
            ),
          )
        ],
      ),
    );
  }
}

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('You have no notification',
        style: TextStyle(fontSize: 20, fontFamily: 'Myriad'));
  }
}
