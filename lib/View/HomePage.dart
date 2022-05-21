import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:guide/Controller/ContractAccess.dart';
import 'package:guide/View/UserHomePage.dart';

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
      Get.put(SmartContractController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // balance = connectTOChain(widget.url, widget.privateKey);
    // ethClient = Web3Client(widget.url, Client());
    // balance = connectTOChain(widget.privateKey);
    // certificatesIds = query("getCurrentUserCertificateIDs", [],
    //     EthereumAddress.fromHex("0xd430d224465e53013D49679b173d7E2c9f63394e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<SmartContractController>(
            // stream: null,
            builder: (controller) {
          return Center(
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: contractAddress,
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: const Text("add contract address"),
                    onPressed: () {
                      // loadContract(contractAddress.text);
                      // loadContract(
                      //     contractAddress: contractAddress.text.length > 0
                      //         ? contractAddress.text
                      //         : "0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6");
                    },
                  ),
                ),
                FutureBuilder(
                    future: contractController.getAccountBalance(),
                    builder: (BuildContext context,
                        AsyncSnapshot<EtherAmount> snapshot) {
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
                      // certificatesIds = query(
                      //     "getCurrentUserCertificateIDs",
                      //     [],
                      //     EthereumAddress.fromHex(
                      //         "0xd430d224465e53013D49679b173d7E2c9f63394e"));
                    },
                    child: const Text("get ui")),
                Expanded(
                  child: Container(
                    child: Obx(() => contractController.certRequested.value ==
                            "notRq"
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
                                        controller.certIds.value?.first.length,
                                    itemBuilder: (_, index) {
                                      return ListTile(
                                          onTap: (() => Get.to(UserHomePage())),
                                          title: Text(
                                              "certs ${controller.certIds.value?.first[index]}"));
                                    }))),
                  ),
                )

                //  Container(
                //                 child: Obx(() => contractController.certRequested == "noRq"
                //                     ? Container(
                //                         child: Text("No certs here"),
                //                       )
                //                     : contractController.certRequested == "Requested"
                //                         ? Container(
                //                             child: Text("Loading"),
                //                           )
                //                         : ),
                //               )
              ],
            ),
          );
        }),
      ),
    );
  }
}
