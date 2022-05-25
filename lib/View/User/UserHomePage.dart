import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/User/listCertificateAccess.dart';

import 'package:guide/View/UserRequestsPage.dart';
import 'package:guide/View/User/showCertificate.dart';
import 'package:web3dart/web3dart.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late Future<EtherAmount> balance;
  late Future<bool> loaded;

  late Future<List<dynamic>> certificatesIds;

  TextEditingController contractAddress = TextEditingController();
  TextEditingController functionArgument = TextEditingController();
  SmartContractController contractController =
      Get.find<SmartContractController>();
  @override

  // List<CertificateList> items = [];
  @override
  void initState() {
    super.initState();
    contractController.fetchAllCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          title:
              // Text('Your Certificates '),
              ListTile(
            title: Text('Your Certificates '),
            subtitle: Container(
              child: Obx(
                () => (Text(contractController.userAddress.toString())),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person),
            )
          ],
        ),
        body: Obx(() => contractController.fetchAllCertRequest.value == "notRq"
            ? Container(
                child: Text(" "),
              )
            : contractController.fetchAllCertRequest.value == "Requested"
                ? Center(child: Container(child: CircularProgressIndicator()))
                : ListView.builder(
                    itemCount: contractController.certificates.value?.length,
                    itemBuilder: (context, index) {
                      print(
                          "certificates length after fetch : ${contractController.certificates.value}");
                      return ListTile(
                        // leading: Text(),
                        title: Text(
                            contractController.certificates.value?[index].data),
                        subtitle: Text(contractController
                                .certificates.value?[index].accessGranted
                                .toString() ??
                            "asd"),
                        onTap: () {
                          Get.to(CertificatePage(
                              certificates: contractController
                                  .certificates.value?[index]));
                        },
                      );
                    },
                  )));
  }
}
