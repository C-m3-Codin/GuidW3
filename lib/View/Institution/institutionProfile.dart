import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:guide/Controller/Contract_controller.dart';
import 'package:guide/View/viewInstaProfile.dart';

class InstitutionProfilePage extends StatefulWidget {
  const InstitutionProfilePage({Key? key}) : super(key: key);

  @override
  _InstitutionProfilePageState createState() => _InstitutionProfilePageState();
}

class _InstitutionProfilePageState extends State<InstitutionProfilePage> {
  SmartContractController contractController =
      Get.find<SmartContractController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          // mainAxisAlignment: Mai,
          children: [
            Text('Institution Profile '),
            Obx(() => Container(
                  child: contractController.instProfile.value!.isVerified
                      ? Icon(
                          Icons.verified,
                          color: Colors.green,
                        )
                      : Icon(Icons.error_outline),
                ))
          ],
        )),
        body: Obx(() => contractController.profileRequest.value == "notRq"
            ? Container(
                child: Text(" "),
              )
            : contractController.profileRequest.value == "Requested"
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
                              'Verification status: ${contractController.instProfile.value!.isVerified} '),
                      InstProfileField(
                          data:
                              ' Institution type: ${contractController.instProfile.value!.institutionType}'),
                      InstProfileField(
                          data:
                              'Main institution: ${contractController.instProfile.value!.mainInstitution}'),
                      InstProfileField(
                          data:
                              'typeInt: ${contractController.instProfile.value!.typeInt}'),
                      GestureDetector(
                          onTap: () {
                            Get.to(ViewInstProfule(
                              address: contractController
                                  .instProfile.value!.verifier,
                            ));
                          },
                          child: InstProfileField(
                              data:
                                  'Verifier: ${contractController.instProfile.value!.verifier}')),
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
