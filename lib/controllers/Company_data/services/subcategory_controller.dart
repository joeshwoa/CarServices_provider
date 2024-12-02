import 'dart:developer';

import 'package:autoflex/models/products/addServiceForm.dart';
import 'package:autoflex/models/products/company_products.dart';
import 'package:autoflex/services/products/productsServices.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:autoflex/models/products/categories.dart' as SubCategories;
import 'package:get/get_rx/get_rx.dart';

class SubCategoryController extends GetxController {
  var loading = false.obs;
  var aboutToDisable = false.obs;
  var subSelected = <Map<String, dynamic>>[].obs;
  var subCategories = <SubCategories.Datum>[].obs;
  var currentSubCategory = 0;
  var existingCategories = <Item>[].obs;

  //DUMMY DATA
  var service = Data().obs;
  //service rates controllers for text/switch/label
  final subCategoryFormKey = GlobalKey<FormState>();
  var servisesRates = <Datum>[].obs;
  var serviceRatesControllers = <TextEditingController>[].obs;
  var itemsSelected = <RxBool>[].obs;
  var selectedServiceRates = <PriceList>[].obs;

  var descriptionLength = 1.obs;
  var descriptionControllers = [TextEditingController()].obs;

  var informationLength = 1.obs;
  var informationControllers = [TextEditingController()].obs;

  //addons controllers
  var addonsLength = 0.obs;
  var addonsControllers = <AddOnsControllers>[].obs;
  var selectedAddons = <AddOn>[].obs;

  var serviceDurationController = TextEditingController().obs;
  var power = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getSubCategories(Get.arguments['categoryId']);
    await getServices();
    await getVehicleTypes();
    initControllers();
  }

  initControllers() {
    serviceRatesControllers.value =
        List.generate(servisesRates.length, (index) => TextEditingController());
    itemsSelected.value =
        List.generate(servisesRates.length, (index) => false.obs);
  }

  //THIS ID IS THE COMPANY'S PRODUCT ID
  editService(id) async {
    loading.value = true;
    await getService(id);
    if (service.value.id != null) {
      //populate the service rates
      selectedServiceRates.value = service.value.priceList!;
      selectedAddons.value = service.value.addOns!;
      for (int i = 0; i < selectedServiceRates.length; i++) {
        itemsSelected[selectedServiceRates[i].carTypeId! - 1] = true.obs;
        serviceRatesControllers[selectedServiceRates[i].carTypeId! - 1].text =
            selectedServiceRates[i].price.toString();
      }

      //populate description and additional information
      descriptionControllers[0].text = service.value.description![0];
      for (int i = 1; i < service.value.description!.length; i++) {
        addField('description');
        descriptionControllers[i].text = service.value.description![i];
      }
      informationControllers[0].text = service.value.additionalInformation![0];
      for (int i = 1; i < service.value.additionalInformation!.length; i++) {
        addField('information');
        informationControllers[i].text =
            service.value.additionalInformation![i];
      }

      //populate addon fields
      for (int i = 0; i < selectedAddons.value.length; i++) {
        addField('addon');
        addonsControllers[i].name.value.text = service.value.addOns![i].name!;
        addonsControllers[i].description.value.text =
            service.value.addOns![i].description!;
        addonsControllers[i].price.value.text =
            service.value.addOns![i].price!.toString();
        addonsControllers[i].multiQty.value =
            service.value.addOns![i].multiQty!;
      }

      //populate duration and power
      power.value = service.value.powerOutlet!;
      serviceDurationController.value.text = service.value.duration!;
    }
    loading.value = false;
  }

  Future<void> getServices() async {
    loading.value = true;
    var getServicesRequest = await ProductsServices.getServices();
    existingCategories.value = getServicesRequest!.data!;
    subSelected.value = List.generate(
      subCategories.length,
      (index) => {
        "selected": false.obs,
        "product_id": subCategories[index].id,
        "id": null // Initialize with null or any default value
      },
    );

    for (var i = 0; i < subSelected.length; i++) {
      var selectedItem = subSelected[i];

      // Find items in existingServices where product_id matches subSelected[i].product_id
      var matchingServices = existingCategories.where((service) {
        return service.productId == selectedItem['product_id'];
      }).toList();

      // If matching services are found, set selected to true and store the service id
      if (matchingServices.isNotEmpty) {
        selectedItem['selected'].value = true;
        selectedItem['id'] = matchingServices.first.id;
      }
    }
    loading.value = false;
  }

  Future<void> getService(id) async {
    loading.value = true;
    var getServiceRequest = await ProductsServices.getService(id);
    service.value = getServiceRequest!.data!;
    loading.value = false;
  }

  Future<void> getSubCategories(categoryId) async {
    loading.value = true;
    var getSubCategoriesRequest =
        await ProductsServices.getSubCategories(categoryId);
    subCategories.value = getSubCategoriesRequest!.data!;
    currentSubCategory = categoryId;

    inspect(currentSubCategory);
    loading.value = false;
  }

  Future<void> getVehicleTypes() async {
    loading.value = true;
    var getSubCategoriesRequest = await ProductsServices.getVehicleTypes();
    servisesRates.value = getSubCategoriesRequest!.data!;
    loading.value = false;
  }

  checkValidation() {
    final isValid = subCategoryFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addService(subId) async {
    var validatePrice = selectedServiceRates.map((element) {
      if (element.price == null) {
        return false;
      } else {
        return true;
      }
    }).toList();
    if (selectedServiceRates.value.isEmpty) {
      Get.snackbar(
          "Invalid Service".tr, "At Least 1 Service Rate Is Required".tr,
          backgroundColor: ConstantColors.errorColor, colorText: Colors.white);
    } else if (validatePrice.contains(false)) {
      Get.snackbar("Invalid Service".tr, "Please enter a Valid Service Rate".tr,
          backgroundColor: ConstantColors.errorColor, colorText: Colors.white);
    } else if (checkValidation()) {
      loading.value = true;
      createAddons();
      var getSubCategoriesRequest = await ProductsServices.activateSubCategory(
          description:
              descriptionControllers.map((element) => element.text).toList(),
          additional:
              informationControllers.map((element) => element.text).toList(),
          productId: subId,
          categoryId: Get.arguments['categoryId'],
          priceList: selectedServiceRates.value,
          duration: serviceDurationController.value.text,
          prower: power.value,
          addons: selectedAddons.value);
      if (getSubCategoriesRequest == null) {
        toast(message: 'Something Went Wrong'.tr);
      } else {
        toast(message: 'The Service has been added to your Company'.tr);
        resetFields();
        await getServices();
        Get.back();
      }
    }
    loading.value = false;
  }

  Future<void> updateService(
      {required int subId, required int? companySubId}) async {
    var validatePrice = selectedServiceRates.map((element) {
      if (element.price == null) {
        return false;
      } else {
        return true;
      }
    }).toList();
    if (validatePrice.contains(false)) {
      toast(message: "Please enter a Valid Service Rate".tr);
    } else if (checkValidation()) {
      loading.value = true;
      createAddons();
      var getSubCategoriesRequest = await ProductsServices.modifySubCategory(
          companySubId: companySubId!,
          description:
              descriptionControllers.map((element) => element.text).toList(),
          additional:
              informationControllers.map((element) => element.text).toList(),
          productId: subId,
          categoryId: Get.arguments['categoryId'],
          priceList: selectedServiceRates.value,
          duration: serviceDurationController.value.text,
          prower: power.value,
          addons: selectedAddons.value);
      if (getSubCategoriesRequest == null) {
        toast(message: 'Something Went Wrong'.tr);
      } else {
        toast(message: 'The Service has been updated!'.tr);
        await getServices();
        resetFields();
        Get.back();
      }
    }
    loading.value = false;
  }

  Future<void> disableService(companySubId) async {
    loading.value = true;
    var disableServiceRequest =
        await ProductsServices.disableService(companySubId);
    if (disableServiceRequest['message'] != null) {
      toast(message: 'The Service Has Been Disabled for your Company'.tr);
      await getServices();
      resetFields();
      Get.back();
    } else {
      toast(message: 'Could not Disable the Service at this moment'.tr);
    }
    loading.value = false;
  }

  void addServiceRate(int id) {
    if (itemsSelected[id - 1].value) {
      var name = servisesRates.firstWhere((item) => item.id == id).name;
      var price = double.tryParse(serviceRatesControllers[id - 1].text);

      // Check if the item already exists in the selectedServiceRates list
      var existingItemIndex =
          selectedServiceRates.indexWhere((item) => item.carTypeId == id);

      if (existingItemIndex != -1) {
        // Update the existing item's price
        selectedServiceRates[existingItemIndex].price = price;
      } else {
        // Add a new item
        var priceList = PriceList(carTypeId: id, carType: name, price: price);
        selectedServiceRates.add(priceList);
      }
    }
  }

  removeServiceRate(id) {
    selectedServiceRates.removeWhere((item) => item.carTypeId == id);
  }

  addField(name) {
    if (name == 'description') {
      descriptionLength.value++;
      descriptionControllers.add(TextEditingController());
    } else if (name == 'information') {
      print('hello?');
      informationLength.value++;
      informationControllers.add(TextEditingController());
    } else {
      addonsLength.value++;
      addonsControllers.add(AddOnsControllers(
        name: TextEditingController().obs,
        description: TextEditingController().obs,
        price: TextEditingController().obs,
        multiQty: false.obs,
      ));
    }
  }

  createAddons() {
    selectedAddons.clear();
    for (var i = 0; i < addonsLength.value; i++) {
      var addon = AddOn(
          name: addonsControllers[i].name.value.text,
          description: addonsControllers[i].description.value.text,
          price: double.tryParse(addonsControllers[i].price.value.text),
          multiQty: addonsControllers[i].multiQty.value);
      selectedAddons.add(addon);
    }
  }

  resetFields() {
    descriptionLength.value = 1;
    informationLength.value = 1;
    addonsLength.value = 0;
    selectedServiceRates.clear();
    selectedAddons.clear();
    serviceDurationController.value.text = '';
    power.value = false;
    descriptionControllers.value = [TextEditingController()];
    serviceRatesControllers.value =
        List.generate(servisesRates.length, (index) => TextEditingController());
    itemsSelected.value =
        List.generate(servisesRates.length, (index) => false.obs);
    informationControllers.value = [TextEditingController()];
    addonsControllers.value = [];
    service.value = Data();
  }
}

class AddOnsControllers {
  Rx<TextEditingController> name;
  Rx<TextEditingController> description;
  Rx<TextEditingController> price;
  RxBool multiQty;

  AddOnsControllers(
      {required this.name,
      required this.description,
      required this.price,
      required this.multiQty});
}
