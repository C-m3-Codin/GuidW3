import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/Institution/VerificationRequestedCertificatePage.dart';

class RequestVerificationList extends StatefulWidget {
  const RequestVerificationList({Key? key}) : super(key: key);

  @override
  State<RequestVerificationList> createState() =>
      _RequestVerificationListState();
}

class _RequestVerificationListState extends State<RequestVerificationList> {
  SmartContractController contractController =
      Get.find<SmartContractController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contractController.allVerificationRequestedCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certificate Approval requests"),
      ),
      body: Obx(() => contractController.fetchAllCertRequest.value == "notRq"
          ? Container(
              child: Text(" "),
            )
          : contractController.fetchAllCertRequest.value == "loading"
              ? showLoading()
              : listOfRequestedCertificates()),
    );
  }

  Center showLoading() =>
      Center(child: Container(child: CircularProgressIndicator()));

  ListView listOfRequestedCertificates() {
    return ListView.builder(
      itemCount:
          contractController.certificatesRequestVerification.value?.length,
      itemBuilder: (context, index) {
        return ListTile(
          // leading: Text(),
          // trailing: ,
          title: Text(contractController
              .certificatesRequestVerification.value?[index].data),
          subtitle: Text(contractController
                  .certificatesRequestVerification.value?[index].accessGranted
                  .toString() ??
              "asd"),
          onTap: () {
            print("instition certificate page");
            Get.to(InstitutionCertificatePage(
                certificates: contractController
                    .certificatesRequestVerification.value?[index]));
          },
        );
      },
    );
  }
}
