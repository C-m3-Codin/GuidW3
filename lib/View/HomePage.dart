import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:guide/Controller/ContractAccess.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/View/Institution/InstHomepage.dart';
import 'package:guide/View/User/UserHomePage.dart';
import 'package:guide/View/User/showCertificate.dart';
import 'package:lottie/lottie.dart';

import 'package:web3dart/web3dart.dart';

import '../Controller/Contract_controller.dart';

class HoemPage extends StatefulWidget {
  // String url;
  // String privateKey;
  HoemPage({Key? key}) : super(key: key);

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  late Future<EtherAmount> balance;
  late Future<bool> loaded;

  late Future<List<dynamic>> certificatesIds;

  TextEditingController contractAddress = TextEditingController();
  TextEditingController functionArgument = TextEditingController();
  SmartContractController contractController =
      Get.find<SmartContractController>();

  TextEditingController searchAddress = TextEditingController();
  bool test = true;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    ;
    contractController.linkContractAfterAuth();
  }

  @override
  Widget build(BuildContext context) {
    print("got to HomePage");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: TextField(
                    controller: searchAddress,
                  ),
                  actions: [
                    TextButton(
                        onPressed: (() {
                          Navigator.pop(context);
                          // print(a);
                        }),
                        child: Text('CANCEL')),
                    TextButton(
                        onPressed: (() async {
                          var a = await contractController.searchCertificate(
                              BigInt.from(int.parse(searchAddress.text)));
                          // Navigator.pop(context);
                          print(a);
                          if (a == "You do not have access to Certificate") {
                          } else {
                            print("going to");
                            Get.to(CertificatePage(
                              certificates: Certificates(a[0]),
                            ));
                          }
                        }),
                        child: Text('Search')),
                  ],
                );
              });
        },
        child: Icon(Icons.search),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          test
              ? Center(
                  child:
                      Obx(() => (contractController.isInstituiton.value == true
                          ? goToInstitutionPage()
                          : contractController.loadedAccount.value != "loaded"
                              ? CircularProgressIndicator()
                              : goToUserPage())),
                )
              : pageToDebug(),
        ],
      )
          // get X// }),
          ),
    );
  }

  Center pageToDebug() {
    return Center(
      child: Column(
        children: [
          Container(
            child: TextField(
              controller: contractAddress,
            ),
          ),
          FutureBuilder(
              future: contractController.getAccountBalance(),
              builder:
                  (BuildContext context, AsyncSnapshot<EtherAmount> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    child: const Text("waiting"),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    child: const Text("Error in snapshot"),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text("Balance"),
                        ),
                        Container(
                          child: Text("Ether  :" +
                              snapshot.data!.getInEther.toString()),
                        ),
                      ],
                    ),
                  );
                }
              }),
          Container(
            child: const Text("Enter addreess"),
          ),
          Container(
            child: TextField(
              controller: functionArgument,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                contractController.getRole();
              },
              child: Obx(() => contractController.roleRequested == "notRq"
                  ? Text("Check Role")
                  : contractController.roleRequested == "Requested"
                      ? CircularProgressIndicator()
                      : Text("${contractController.role.value}"))),

          // Text("Check Role")),
          ElevatedButton(
              onPressed: () {
                contractController.getCertIds();
              },
              child: const Text("get ui")),
          Expanded(
            child: Container(
              child: Obx(() => contractController.certRequested.value == "notRq"
                  ? Container(
                      child: Text("No certs here"),
                    )
                  : contractController.certRequested.value == "Requested"
                      ? Container(
                          child: Text(
                              "Loading ${contractController.certRequested.value}"),
                        )
                      : Container(
                          child: ListView.builder(
                              itemCount:
                                  contractController.certIds.value?.length,
                              itemBuilder: (_, index) {
                                return ListTile(
                                    onTap: (() => Get.to(UserHomePage())),
                                    title: Text(
                                        "certs ${contractController.certIds.value?[index]}"));
                              }))),
            ),
          )
        ],
      ),
    );
  }

  Column goToUserPage() {
    contractController.getCertIds();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_fgp8rk11.json'),
        Container(
          child: ElevatedButton(
              onPressed: () {
                print(
                    "ther profile is an Inst? ${contractController.isInstituiton}");
                Get.to(UserHomePage());
              },
              child: Text("Go to User page")),
        ),
      ],
    );
  }

  Column goToInstitutionPage() {
    contractController.getRequestedCerts();
    return Column(
      children: [
        Lottie.network(
            'https://assets9.lottiefiles.com/private_files/lf30_pn4etzyv.json'),
        Container(
          child: ElevatedButton(
              onPressed: () {
                print(
                    "ther profile is an Inst? ${contractController.isInstituiton}");

                Get.to(InstHome());
              },
              child: Text("Go to Institution page")),
        ),
      ],
    );
  }
}
