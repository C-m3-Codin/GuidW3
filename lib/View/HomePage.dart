import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:guide/Controller/ContractAccess.dart';

import 'package:web3dart/web3dart.dart';

import '../Controller/Contract_controller.dart';

class HoemPage extends StatefulWidget {
  String url;
  String privateKey;
  HoemPage({Key? key, required this.url, required this.privateKey})
      : super(key: key);

  @override
  State<HoemPage> createState() => _HoemPageState();
}

class _HoemPageState extends State<HoemPage> {
  late Future<EtherAmount> balance;
  late Future<bool> loaded;

  late Future<List<dynamic>> certificatesIds;

  TextEditingController contractAddress = TextEditingController();
  TextEditingController functionArgument = TextEditingController();
  SmartContractController ContractController =
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
                    future: ContractController.getAccount(),
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
                      query(
                          "getRole",
                          [
                            EthereumAddress.fromHex(
                                "0x7d1fbB509D948890007e9cdfBd599e01740f9ba0")
                          ],
                          EthereumAddress.fromHex(
                              "0xd430d224465e53013D49679b173d7E2c9f63394e"));
                    },
                    child: const Text("Check Role")),
                ElevatedButton(
                    onPressed: () {
                      certificatesIds = query(
                          "getCurrentUserCertificateIDs",
                          [],
                          EthereumAddress.fromHex(
                              "0xd430d224465e53013D49679b173d7E2c9f63394e"));
                    },
                    child: const Text("get ui")),
                FutureBuilder(
                    future: certificatesIds,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.none) {
                        return Container(
                          child: const Text("Load Data"),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          child: const CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            // itemCount: storesVisible.length,
                            itemCount: snapshot.data[0].length,
                            itemBuilder: (_, i) {
                              return ListTile(
                                onTap: () {
                                  // TODO get certificate
                                  Future<List<dynamic>> cert = queryGetCert(
                                      snapshot.data[0][i],
                                      EthereumAddress.fromHex(
                                          "0xd430d224465e53013D49679b173d7E2c9f63394e"),
                                      "getCertificate");
                                },
                                title: Text(
                                    "Certificate Id : ${snapshot.data[0][i].toString()}"),
                              );
                            });
                      }
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
