import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<bool> showNotificationWithButtons(
    {@required int id, @required DateTime scheduleDateTime}) async {
  return AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: id,
          channelKey: 'basic_channel',
          title: 'Hi',
          body: 'Last date to submit assignment sunday',
          payload: {'uuid': 'user-profile-uuid'}),
      schedule: NotificationCalendar(
          timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
          hour: scheduleDateTime.hour,
          minute: scheduleDateTime.minute,
          second: 0,
          allowWhileIdle: true,
          repeats: true),
      actionButtons: [
        NotificationActionButton(
            key: 'NOW',
            label: 'Okay',
            enabled: true,
            buttonType: ActionButtonType.Default),
        NotificationActionButton(
            key: 'LATER',
            label: 'will do it later',
            enabled: true,
            buttonType: ActionButtonType.Default)
      ]);
}
