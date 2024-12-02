 import 'package:autoflex/controllers/worker/worker_menu_controller.dart';
import 'package:autoflex/models/company%20workers/WorkerDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WorkerDataController extends GetxController {
  WorkerMenuController workerMenuController = WorkerMenuController();
  var loading=false.obs;
 final WorkerDataFormKey = GlobalKey<FormState>();
  Rx<XFile?> workerImage = XFile("").obs;
    var isPlaceholderVisible = true.obs;
    var iswhatsAppPlaceholderVisible = true.obs;
  var imageUploaded=false.obs;
    var showwhatsApp = false.obs;
    TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = TextEditingController(text: "+971");

  @override
  void onInit() {
    workerMenuController = Get.find<WorkerMenuController>();
    print("+971${workerMenuController.workerDetails.value.data!.phone??''}");
    isPlaceholderVisible.value = phoneController.text == "+971";
    iswhatsAppPlaceholderVisible.value = whatsappController.text == "+971";
    super.onInit();
  }

 changePhotoRequest(type) async {
    try {
      if(type=='gallery'){
      workerImage.value = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      print(workerImage.value!.path);}
      else{
          workerImage.value = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      }
      imageUploaded.value = true;
     
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  updateDetails()  async {
    loading.value = true;
    print(workerImage.value!.path);
    await workerMenuController.updateWorkerDetails(
        WorkerDetails(
            data: Data(
                id: workerMenuController.workerDetails.value.data!.id,
                fullName: nameController.text,
                phone: phoneController.text,
                whatsappNumber: whatsappController.text,
                image: workerImage.value!.path.isEmpty? workerMenuController.workerDetails.value.data!.image : workerImage.value!.path,
                companyId: workerMenuController.workerDetails.value.data!.companyId,
                categories: workerMenuController.workerDetails.value.data!.categories,
                title: workerMenuController.workerDetails.value.data!.title,
                username: workerMenuController.workerDetails.value.data!.username,
                updatedAt: workerMenuController.workerDetails.value.data!.updatedAt,
                createdAt: workerMenuController.workerDetails.value.data!.createdAt,
            )
        )
    );
    loading.value = false;
  }
 }