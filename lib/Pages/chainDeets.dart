import 'package:flutter/material.dart';
import 'package:guide/Pages/HomePage.dart';

class ChainSelection extends StatefulWidget {
  const ChainSelection({Key? key}) : super(key: key);

  @override
  State<ChainSelection> createState() => _ChainSelectionState();
}

class _ChainSelectionState extends State<ChainSelection> {
  TextEditingController chainUrl = new TextEditingController();
  TextEditingController privateKey = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Select Chain"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text("Chain url"),
              ),
              Container(
                height: 20,
                child: TextField(
                  controller: chainUrl,
                ),
              ),
              Container(
                child: Text("private  key"),
              ),
              Container(
                height: 20,
                child: TextField(
                  controller: privateKey,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HoemPage(
                                // url: chainUrl.text, privateKey: privateKey.text)),
                                url: chainUrl.text.length == 0
                                    ? "HTTP://192.168.0.106:7545"
                                    : chainUrl.text,
                                privateKey: privateKey.text.length == 0
                                    ? "B5f676dae41411258554065249081daba3bbe2dca43a7c6e9a01526f17a15c25"
                                    : privateKey.text)));
                    // TODO login to the link provided
                  },
                  child: Container(
                    child: Text("Login"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
