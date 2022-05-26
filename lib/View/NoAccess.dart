import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class SorryNoAccess extends StatelessWidget {
  const SorryNoAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_hykq5eib.json"),
          Text(
            "Sorry You dont have access \n Please Request for access",
            style: TextStyle(fontSize: 20),
          )
        ],
      )),
    );
  }
}
