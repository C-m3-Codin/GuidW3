import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/Model/CertificateModel.dart';
import 'package:guide/View/User/listCertificateAccess.dart';
import 'package:web3dart/credentials.dart';
import 'package:get/get.dart';

class CertificatePage extends StatefulWidget {
  Certificates certificates;
  CertificatePage({Key? key, required this.certificates}) : super(key: key);

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  SmartContractController contractController =
      Get.find<SmartContractController>();

  // static var Get;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("certificate"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Text(widget.certificates.data),
              ),
              Container(
                child: Expanded(
                    child: ListView.builder(
                        itemCount: widget.certificates.accessGranted.length,
                        itemBuilder: (_, index) {
                          return ListTile(
                              onTap: () {
                                Get.to(CertificateAccessList(
                                  certificates: widget.certificates,
                                ));
                              },
                              title: Text(
                                  "${widget.certificates.accessGranted[index]}"));
                        })),
              ),
              Container(child: Text("Accounts with access to this")),
              ElevatedButton(
                  onPressed: () {
                    contractController.grantCertificateAccessTo(
                        widget.certificates.certificateId.toInt(),
                        EthereumAddress.fromHex(
                            "0xC009792C65581FDaEFC6FD5bEFe4B4e3130E9F42"));
                  },
                  child: Text("add access to")),
            ],
          ),
        ),
      ),
    );
  }
}
