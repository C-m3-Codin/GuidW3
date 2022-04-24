import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  EtherAmount balance = new EtherAmount.zero();
  late Future<bool> loaded;

  TextEditingController contractAddress = new TextEditingController();

  Future<DeployedContract> loadContract(
      {String contractAddress =
          "0x45c7DC5c7CB32f989C64cE20269E714dcf0886f6"}) async {
    final abi = await rootBundle.loadString("assets/Guide.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Guide"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<bool> connectTOChain() async {
    // start a client we can use to send transactions
    final client = Web3Client(widget.url, Client());

    final credentials = EthPrivateKey.fromHex(widget.privateKey);
    final address = credentials.address;

    print(address.hexEip55);
    print(await client.getBalance(address));
    balance = await client.getBalance(address);
    return true;

    await client.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaded = connectTOChain();
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
                  future: loaded,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
                              child: Text(
                                  "Ether  :" + balance.getInEther.toString()),
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
