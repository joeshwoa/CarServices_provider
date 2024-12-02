import 'package:autoflex/services/faqs_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class FAQsController extends GetxController {
  ExpansionTileController expanded = ExpansionTileController();
  var questions = [].obs;

  var expandedIndex = (-1).obs; // -1 means no tile is expanded

  final List<ExpansionTileController> controllers = [];
  var loading=false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getFAQs();
  }

  void changeQuestion(int index) {
    if (expandedIndex.value == index) {
      controllers[expandedIndex.value]
          .collapse(); // Collapse the tile if it's already expanded
      expandedIndex.value = -1; // Collapse all tiles
    } else {
      if (expandedIndex.value != -1) {
        controllers[expandedIndex.value]
            .collapse(); // Collapse the previously expanded tile
      }
      expandedIndex.value = index;
      controllers[expandedIndex.value].expand(); // Expand the clicked tile
    }
    refresh();
  }

  Future<void> getFAQs() async {
    print('getFAQs');
    try {
      loading.value = true;
      List<dynamic>? getFAQsRequest = await FAQsService.getFAQs();
      print(getFAQsRequest);
      questions.value=getFAQsRequest??[];

      controllers.addAll(
          List.generate(questions.length, (_) => ExpansionTileController()));

      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
