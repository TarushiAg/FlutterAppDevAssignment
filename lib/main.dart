import 'package:app_developer_assignment/HomeScreen.dart';
import 'package:app_developer_assignment/LoginScreen.dart';
import 'package:app_developer_assignment/SharedPreferenceUtils.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
          child: PreferenceUtils.getString(
                          PreferenceUtils.KEY_CUSTOMER_USERNAME) ==
                      null ||
                  PreferenceUtils.getString(
                          PreferenceUtils.KEY_CUSTOMER_USERNAME) ==
                      ""
              ? LoginScreen()
              : HomeScreen()),
    );
  }
}
