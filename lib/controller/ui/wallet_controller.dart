import 'package:flutter/material.dart';
import 'package:myfoody/model/wallet_data.dart';
import 'package:myfoody/views/my_controller.dart';

import 'package:myfoody/views/ui/wallet_screen.dart';

class WalletController extends MyController {
  List<WalletData> wallet = [];

  DataTableSource? data;

  @override
  void onInit() {
    WalletData.dummyList.then((value) {
      wallet = value.sublist(0, 10);
      data = MyData(wallet);
      update();
    });
    super.onInit();
  }

  @override
  void onThemeChanged() {
    data = MyData(wallet);
    update();
  }
}
