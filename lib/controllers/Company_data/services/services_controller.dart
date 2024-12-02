import 'dart:developer';
import 'package:autoflex/models/products/catalogue.dart' as Categories;
import 'package:autoflex/services/products/productsServices.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/services/subCategoriesScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesController extends GetxController {
  var categories = <Categories.Datum>[].obs;
  var loading = false.obs;
  var services = <Widget>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCategories();
  }

  Future<void> getCategories() async {
    loading.value = true;
    var temp = <Widget>[];
    var getCategoriesRequest = await ProductsServices.getCategories();
    categories.value = getCategoriesRequest!.data!;
    for (var i = 0; i < categories.length; i++) {
      temp.add(createButton(
          label: (categories[i].name ?? "").toUpperCase(),
          prefixIcon: categories[i].logoUrl ?? "",
          suffixIcon: navigateNext,
          screen: () {
            Get.to(() => SubCategoriesScreen(title: categories[i].name ?? ""),
                arguments: {'categoryId': categories[i].id});
          }));
    }
    services.value = temp;
    inspect(getCategoriesRequest.data);
    loading.value = false;
  }
}
