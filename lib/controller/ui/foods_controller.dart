import 'package:flutter/material.dart';
import 'package:myfoody/model/product_data.dart';
import 'package:myfoody/views/my_controller.dart';

class FoodsController extends MyController {
  RangeValues rangeSlider = RangeValues(10, 100);
  bool isChecked = false;
  List multipleSelected = [];
  List<ProductData> products = [];

  @override
  void onInit() {
    ProductData.dummyList.then((value) {
      products = value;
      update();
    });
    super.onInit();
  }

  void onChangeRangeSlider(RangeValues value) {
    rangeSlider = value;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  List checkListItems = [
    {"value": false, "title": "Rice & Pluses"},
    {"value": true, "title": "Beverages"},
    {"value": false, "title": "Snacks & Munchies"},
    {"value": false, "title": "Bakery"},
    {"value": true, "title": "Dairy"},
    {"value": false, "title": "Vegetables"},
    {"value": false, "title": "Fruits"},
  ];
}
