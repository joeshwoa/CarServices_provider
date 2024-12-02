import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisablePopUp extends StatelessWidget {
  const DisablePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Get.isDialogOpen!) {
            Get.back(result: false); // Ensure only the dialog is closed
          }
        });
        return;
      },
      child: CupertinoAlertDialog(
        title: Text('Disable Service'.tr),
        content: Text('Are you sure you want to delete this Service?'.tr),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Cancel'.tr,
              style: const TextStyle(color: Color(0xFF45464C)),
            ),
            onPressed: () {
              Get.back(result: false); // Pass false to indicate cancellation
            },
          ),
          CupertinoDialogAction(
            child: Text('Disable'.tr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFFFF0000))),
            onPressed: () {
              Get.back(result: true); // Pass true to indicate confirmation
            },
          ),
        ],
      ),
    );
  }
}
