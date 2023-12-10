
import 'package:carecare/AdminPage.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/constants.dart';
import 'package:carecare/mind/onboarding.dart';
import 'package:carecare/min/control.dart';
import 'package:carecare/min/work.dart';
import 'package:carecare/min/detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo dd',
      theme: ThemeData(
        fontFamily: "Cario",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
        
      ),
      home: const onboarding()
    );
  }
}
