import 'package:myfoody/model/order_detail.dart';
import 'package:myfoody/views/my_controller.dart';

class CustomerDetailController extends MyController {
  List<OrderDetail> ordersDetail = [];

  @override
  void onInit() {
    OrderDetail.dummyList.then((value) {
      ordersDetail = value.sublist(0, 10);
      update();
    });
    super.onInit();
  }
}
