import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:task_tracker/routes.dart';

void main() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
      defaultColor: Color(0xFF9D50DD),
      ledColor: Colors.white,
    )
  ]);
  runApp(App());
}

class App extends StatefulWidget {
  App();
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static String name = 'Task Tracker';
  static Color mainColor = Color(0xFF9D50DD);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: App.navKey,
      title: App.name,
      color: App.mainColor,
      debugShowCheckedModeBanner: false,
      initialRoute: PAGE_HOME,
      //onGenerateRoute: generateRoute,
      routes: materialRoutes,
    );
  }
}
