import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:guide/View/HomePage.dart';
import 'package:guide/View/UserRequestCert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:guide/View/Institution/publishCert.dart';
import 'package:guide/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            accentColor: Colors.red,
            brightness: Brightness.dark,
            primaryColor: Colors.amber,
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.amber,
              disabledColor: Colors.grey,
            )),
        home: AuthScreen()
        // PublishCertificate(),
        // home: HoemPage(
        //   url: "url   ",
        //   privateKey: '',
        // ),
        );
  }
}
