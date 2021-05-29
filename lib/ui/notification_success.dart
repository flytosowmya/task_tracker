import 'package:flutter/material.dart';

class NotificationSuccessPage extends StatelessWidget {
  const NotificationSuccessPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Notification received ',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.height * 0.20,
            ),
          ),
        ),
      ),
    );
  }
}
