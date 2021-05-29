import 'package:flutter/material.dart';
import 'package:task_tracker/ui/home.dart';
import 'package:task_tracker/ui/notification_success.dart';

const String PAGE_HOME = '/';
const String PAGE_NOTIFICATION_SUCCESS = '/notification-success';

Map<String, WidgetBuilder> materialRoutes = {
  PAGE_HOME: (context) => HomePage(),
  PAGE_NOTIFICATION_SUCCESS: (context) => NotificationSuccessPage(),
};
