import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:autoflex/models/company.dart';
import 'package:autoflex/models/products/addServiceForm.dart';
import 'package:autoflex/models/products/catalogue.dart';
import 'package:autoflex/models/products/categories.dart';
import 'package:autoflex/models/products/company_products.dart';
import 'package:autoflex/services/constants.dart';
import 'package:flutter/foundation.dart';

class ProductsServices {
  static Future<Catalogue?> getCategories() async {
    var response = await Constants.getNetworkService("v1/categories", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = catalogueFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<CompanyProducts?> getServices() async {
    var response =
        await Constants.getNetworkService("v1/seller/product", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = companyProductsFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Product?> getService(id) async {
    var response =
        await Constants.getNetworkService("v1/seller/product/$id", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = productFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Categories?> getSubCategories(categoryid) async {
    var response = await Constants.getNetworkService(
        "v1/products?category_id=$categoryid", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = categoriesFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<VehicleTypes?> getVehicleTypes() async {
    var response =
        await Constants.getNetworkService("v1/vehicles/types", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = vehicleTypesFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<Product?> activateSubCategory(
      {required int productId,
      required int categoryId,
      required List<PriceList> priceList,
      required List<String> description,
      required List<String> additional,
      required String duration,
      required bool prower,
      required List<AddOn> addons}) async {
    print({
      "product_id": productId,
      "category_id": categoryId,
      "description": description,
      "additional_information": additional,
      "price_list": priceList
          .map((e) => {
                "car_type_id": e.carTypeId,
                "car_type": e.carType,
                "price": e.price
              })
          .toList(),
      "duration": duration,
      "power_outlet": prower,
      "add_ons": addons
          .map((e) => {
                "name": e.name,
                "description": e.description,
                "multi_qty": e.multiQty,
                "price": e.price
              })
          .toList()
    });
    var response =
        await Constants.postNetworkService("v1/seller/product", "withToken", {
      "product_id": productId,
      "category_id": categoryId,
      "description": description,
      "additional_information": additional,
      "price_list": priceList
          .map((e) => {
                "car_type_id": e.carTypeId,
                "car_type": e.carType,
                "price": e.price
              })
          .toList(),
      "duration": duration,
      "power_outlet": prower,
      "add_ons": addons
          .map((e) => {
                "name": e.name,
                "description": e.description,
                "multi_qty": e.multiQty,
                "price": e.price
              })
          .toList()
    });
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = productFromJson(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<Product?> modifySubCategory(
      {required int companySubId,
      required int productId,
      required int categoryId,
      required List<PriceList> priceList,
      required List<String> description,
      required List<String> additional,
      required String duration,
      required bool prower,
      required List<AddOn> addons}) async {
    var response = await Constants.putNetworkService(
        "v1/seller/product/$companySubId", "withToken", {
      "product_id": productId,
      "category_id": categoryId,
      "description": description,
      "additional_information": additional,
      "price_list": priceList
          .map((e) => {
                "car_type_id": e.carTypeId,
                "car_type": e.carType,
                "price": e.price
              })
          .toList(),
      "duration": duration,
      "power_outlet": prower,
      "add_ons": addons
          .map((e) => {
                "name": e.name,
                "description": e.description,
                "multi_qty": e.multiQty,
                "price": e.price
              })
          .toList()
    });
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = productFromJson(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> disableService(id) async {
    var response = await Constants.deleteNetworkService(
        "v1/seller/product/$id", "withToken", {});
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }
}
