import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          child: Text("InstiTution"),
        ),
      ),
    );
  }
}
