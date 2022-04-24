import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guide/Services/ContractAccess.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

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

  TextEditingController contractAddress = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    balance = connectTOChain(widget.url, widget.privateKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: contractAddress,
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("add contract address"),
                  onPressed: () {
                    // loadContract(contractAddress.text);
                    loadContract(
                        contractAddress: contractAddress.text.length > 0
                            ? contractAddress.text
                            : "0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6");
                  },
                ),
              ),
              FutureBuilder(
                  future: balance,
                  builder: (BuildContext context,
                      AsyncSnapshot<EtherAmount> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Text("waiting"),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text("Error in snapshot"),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Balance"),
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
            ],
          ),
        ),
      ),
    );
  }
}
