import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_tracker/utils/notification_utils.dart';

import '../routes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      requestNotificationPermission();
      _addNotificationListener();
    });
  }

  Future<void> showRequestUserPermissionDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Color(0xfffbfbfb),
        title: Text('Get Notified!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/animated-bell.gif',
              height: 200,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Allow Awesome Notifications to send you beautiful notifications!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.grey),
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: Text('Later', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () async {
              await AwesomeNotifications()
                  .requestPermissionToSendNotifications();
              Navigator.of(context).pop();
            },
            child: Text('Allow', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Future<bool> requestNotificationPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await showRequestUserPermissionDialog(context);
      isAllowed = await AwesomeNotifications().isNotificationAllowed();
    }
    return isAllowed;
  }

  _addNotificationListener() {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      Navigator.pushNamed(context, PAGE_NOTIFICATION_SUCCESS);
      Fluttertoast.showToast(
        msg: 'Message Received - ${receivedNotification.title}',
        backgroundColor: Color(0xFF9D50DD),
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Tracker',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                  bottom: size.height * 0.02,
                  left: size.height * 0.03,
                  right: size.height * 0.03,
                ),
                child: Text(
                  'Schedule Notification to remind yourself even if you forget',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.01,
                  left: size.height * 0.03,
                  right: size.height * 0.03,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (await requestNotificationPermission()) {
                      showNotificationWithButtons(
                        id: 1,
                        scheduleDateTime: DateTime.now().add(
                          Duration(minutes: 5),
                        ),
                      );
                      Fluttertoast.showToast(
                          msg: 'Notification Set Successfully',
                          backgroundColor: Color(0xFF9D50DD),
                          textColor: Colors.white);
                    }
                  },
                  child: Text(
                    'Send me notification after 5 mins',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
