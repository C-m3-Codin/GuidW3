import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/CertificatePage.dart';
import 'package:guide/View/UserRequestsPage.dart';
import 'package:web3dart/web3dart.dart';
import 'package:guide/Model/CertificateModel.dart';

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
      Get.put(SmartContractController());

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
          backgroundColor: Colors.white,
          title: const ListTile(
            title: Text('NAME HERE'),
            subtitle: Text('XX XX XXXX XXXX'),
          ),
          actions: [
            TextButton(
              child: const Text('REQUESTS'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserRequestsPage()));
              },
            ),
            TextButton(
              child: Text('REQUEST A CERTIFICATE'),
              onPressed: () {
                print("pressed");
                print("role is ${contractController.role}");
              },
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
                          // contractController.fetchAllCertificates();
                        },
                      );
                    },
                  )));
  }
}
