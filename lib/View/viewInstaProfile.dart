import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
// import 'package:get/route_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';

import 'package:web3dart/credentials.dart';

class ViewInstProfule extends StatefulWidget {
  EthereumAddress address;
  ViewInstProfule({Key? key, required this.address}) : super(key: key);

  @override
  State<ViewInstProfule> createState() => _ViewInstProfuleState();
}

class _ViewInstProfuleState extends State<ViewInstProfule> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contractController.getAnyinstitutionProfile(widget.address);
  }

  SmartContractController contractController =
      Get.find<SmartContractController>();
  @override
  Widget build(BuildContext context) {
    print("address of  institution ${contractController.userAddress}");
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Text('View Institutions '),
            Obx(() => Container(
                  child: contractController.viewProfileRequest.value == "notRq"
                      ? Container(
                          child: Text(" "),
                        )
                      : contractController.viewProfileRequest.value ==
                              "Requested"
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : contractController
                                  .viewInstitutionProfile.value!.isVerified
                              ? Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                )
                              : Icon(Icons.error_outline),
                ))
          ],
        )

            //  Text('View Institutions')

            ),
        body: Obx(() => contractController.viewProfileRequest.value == "notRq"
            ? Container(
                child: Text(" "),
              )
            : contractController.viewProfileRequest.value == "Requested"
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      InstProfileField(
                          data:
                              'Verification status: ${contractController.viewInstitutionProfile.value!.isVerified} '),
                      InstProfileField(
                          data:
                              ' Institution type: ${contractController.viewInstitutionProfile.value!.institutionType}'),
                      InstProfileField(
                          data:
                              'Main institution: ${contractController.viewInstitutionProfile.value!.mainInstitution}'),
                      InstProfileField(
                          data:
                              'typeInt: ${contractController.viewInstitutionProfile.value!.typeInt}'),
                      GestureDetector(
                          onTap: () {
                            print("the click on verifier");
                            contractController.viewProfileRequest.value ==
                                "notRq";
                            Get.to(ViewInstProfule(
                                address: contractController
                                    .viewInstitutionProfile.value!.verifier));
                          },
                          child: InstProfileField(
                              data:
                                  'Verifier: ${contractController.viewInstitutionProfile.value!.verifier}')),
                    ],
                  )));
  }
}

class InstProfileField extends StatelessWidget {
  final String data;
  const InstProfileField({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[100],
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        data,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
