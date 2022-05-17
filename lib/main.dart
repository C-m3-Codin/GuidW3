import 'package:flutter/material.dart';
import 'package:guide/Pages/UserHomePage.dart';
import 'package:guide/Pages/UserRequestCert.dart';
import 'package:guide/Pages/chainDeets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      // home: const ChainSelection(),
      home: UserReqCert(),
    );
  }
}
