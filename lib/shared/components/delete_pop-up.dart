import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeletePopUp extends StatelessWidget {
  final String deletable;
  const DeletePopUp({super.key, required this.deletable});

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
        title: Text('Delete Item'.tr),
        content: Text('${'Are you sure you want to delete this'.tr} $deletable?'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(
              'Cancel'.tr,
              style: TextStyle(color: Color(0xFF45464C)),
            ),
            onPressed: () {
              Get.back(result: false); // Pass false to indicate cancellation
            },
          ),
          CupertinoDialogAction(
            child: Text('Delete'.tr,
                style: TextStyle(
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
