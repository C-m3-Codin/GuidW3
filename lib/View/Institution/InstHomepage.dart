import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:guide/View/Institution/publishCert.dart';

class InstHome extends StatefulWidget {
  const InstHome({Key? key}) : super(key: key);

  @override
  State<InstHome> createState() => _InstHomeState();
}

class _InstHomeState extends State<InstHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Institution Page")),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Get.to(PublishCertificate());
              },
              child: Text("InstiTution")),
        ),
      ),
    );
  }
}
