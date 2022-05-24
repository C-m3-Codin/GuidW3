import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:web3dart/credentials.dart';

class CertificateAccessList extends StatefulWidget {
  CertificateAccessList({Key? key, required this.certificates})
      : super(key: key);

  Certificates certificates;

  @override
  _CertificateAccessListState createState() => _CertificateAccessListState();
}

class _CertificateAccessListState extends State<CertificateAccessList> {
  SmartContractController contractController =
      Get.find<SmartContractController>();
  TextEditingController? controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sharing'),
        ),
        body: ListView.builder(
          itemCount: widget.certificates.accessGranted.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(widget.certificates.accessGranted[index].toString()),
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: TextField(
                      controller: controller,
                    ),
                    actions: [
                      TextButton(
                          onPressed: (() {
                            Navigator.pop(context);
                          }),
                          child: Text('CANCEL')),
                      TextButton(
                          onPressed: () {
                            print(" balue of address ${controller!.text}");
                            contractController.grantCertificateAccessTo(
                                widget.certificates.certificateId,
                                EthereumAddress.fromHex(
                                    controller!.text.toString()));
                          },
                          child: Text('ADD')),
                    ],
                  );
                });
          },
          child: Icon(Icons.person_add),
        ));
  }
}
