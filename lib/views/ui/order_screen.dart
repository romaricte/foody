import 'package:flutter/material.dart';
import 'package:myfoody/controller/ui/order_controller.dart';
import 'package:myfoody/helpers/utils/ui_mixins.dart';
import 'package:myfoody/helpers/utils/utils.dart';
import 'package:myfoody/helpers/widgets/my_breadcrumb.dart';
import 'package:myfoody/helpers/widgets/my_breadcrumb_item.dart';
import 'package:myfoody/helpers/widgets/my_container.dart';
import 'package:myfoody/helpers/widgets/my_flex.dart';
import 'package:myfoody/helpers/widgets/my_flex_item.dart';
import 'package:myfoody/helpers/widgets/my_spacing.dart';
import 'package:myfoody/helpers/widgets/my_text.dart';
import 'package:myfoody/helpers/widgets/responsive.dart';
import 'package:myfoody/model/order_list.dart';
import 'package:myfoody/views/layout/layout.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late OrderController controller;

  @override
  void initState() {
    controller = Get.put(OrderController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Order",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Order', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(
                    child: Column(
                      children: [
                        if (controller.data != null)
                          PaginatedDataTable(
                            header: Row(
                              children: [
                                MyText.titleMedium(
                                  "Order List",
                                  fontWeight: 600,
                                  fontSize: 20,
                                ),
                              ],
                            ),
                            source: controller.data!,
                            columns: [
                              DataColumn(
                                  label: MyText.bodyMedium('Date',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodyMedium('OrderID',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodyMedium('Menu',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodyMedium('Amount',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodyMedium('Status',
                                      fontWeight: 600)),
                              DataColumn(
                                  label: MyText.bodyMedium('Action',
                                      fontWeight: 600)),
                            ],
                            columnSpacing: 200,
                            horizontalMargin: 50,
                            rowsPerPage: 10,
                            dataRowMaxHeight: 60,
                          ),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<OrderList> orderList = [];

  MyData(this.orderList);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orderList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    OrderList order = orderList[index];

    return DataRow(
      cells: [
        DataCell(MyText.bodyMedium(
          Utils.getDateStringFromDateTime(order.dateTime),
          fontWeight: 600,
        )),
        DataCell(MyText.bodyMedium(
          "#${order.orderId}",
          fontWeight: 600,
        )),
        DataCell(Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium(
              order.foodName,
              fontWeight: 600,
            ),
            Row(
              children: [
                Icon(
                  LucideIcons.star,
                  color: contentTheme.primary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodyMedium(
                  order.rating.toString(),
                  fontWeight: 600,
                ),
              ],
            )
          ],
        )),
        DataCell(MyText.bodyMedium("\$ ${order.amount}")),
        DataCell(
          MyContainer(
            padding: MySpacing.xy(12, 4),
            borderRadiusAll: 100,
            color: order.status == 'Refund'
                ? contentTheme.primary.withAlpha(40)
                : order.status == 'Paid'
                    ? contentTheme.success.withAlpha(40)
                    : order.status == 'Cancel'
                        ? contentTheme.danger.withAlpha(40)
                        : null,
            child: MyText.bodyMedium(
              order.status,
              fontWeight: 600,
              color: order.status == 'Refund'
                  ? contentTheme.primary
                  : order.status == 'Paid'
                      ? contentTheme.success
                      : order.status == 'Cancel'
                          ? contentTheme.danger
                          : null,
            ),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () => gotoDetailScreen(),
            borderRadius: BorderRadius.circular(100),
            child: MyContainer(
              padding: MySpacing.xy(12, 4),
              borderRadiusAll: 100,
              color: contentTheme.secondary.withAlpha(40),
              child: Row(
                children: [
                  MyText.bodyMedium(
                    "View",
                    color: contentTheme.secondary,
                    fontWeight: 600,
                  ),
                  MySpacing.width(8),
                  Icon(
                    LucideIcons.eye,
                    size: 20,
                    color: contentTheme.secondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void gotoDetailScreen() {
    Get.toNamed('/admin/orders/detail');
  }
}
