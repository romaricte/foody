import 'package:flutter/material.dart';
import 'package:myfoody/model/order_list.dart';
import 'package:myfoody/views/my_controller.dart';

import 'package:myfoody/views/ui/order_screen.dart';

class OrderController extends MyController {
  List<OrderList> orderList = [];

  DataTableSource? data;

  @override
  void onInit() {
    super.onInit();
    OrderList.dummyList.then((value) {
      orderList = value.sublist(0, 40);
      data = MyData(orderList);
      update();
    });
  }

  @override
  void onThemeChanged() {
    data = MyData(orderList);
    update();
  }
}
