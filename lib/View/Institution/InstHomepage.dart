import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/Institution/institutionProfile.dart';
import 'package:guide/View/Institution/publishCert.dart';
import 'package:guide/View/Institution/requestInstitution.dart';
import 'package:lottie/lottie.dart';
import 'package:web3dart/credentials.dart';

class InstHome extends StatefulWidget {
  const InstHome({Key? key}) : super(key: key);

  @override
  State<InstHome> createState() => _InstHomeState();
}

class _InstHomeState extends State<InstHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contractController.geCurrenttinstitutionProfile(
        contractController.userAddress.value ?? EthereumAddress.fromHex("0X"));
  }

  SmartContractController contractController =
      Get.find<SmartContractController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Institution Page"),
          actions: [goToProfile()],
        ),
        body: Center(
          child: Column(
            children: [
              Lottie.network(
                  'https://assets9.lottiefiles.com/private_files/lf30_pn4etzyv.json'),
              ElevatedButton(
                  onPressed: () {
                    Get.to(PublishCertificate());
                  },
                  child: Text("Publish Certificate")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(RequestVerificationList());
                  },
                  child: Text("Requested Institution"))
            ],
          ),
        ),
      ),
    );
  }

  Padding goToProfile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () {
            Get.to(InstitutionProfilePage());
          },
          child: Icon(Icons.person)),
    );
  }
}
