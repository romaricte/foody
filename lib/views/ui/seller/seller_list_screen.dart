import 'package:flutter/material.dart';
import 'package:myfoody/controller/ui/seller/seller_list_controller.dart';
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
import 'package:myfoody/images.dart';
import 'package:myfoody/model/customer_list.dart';
import 'package:myfoody/views/layout/layout.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SellerListScreen extends StatefulWidget {
  const SellerListScreen({super.key});

  @override
  State<SellerListScreen> createState() => _SellerListScreenState();
}

class _SellerListScreenState extends State<SellerListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late SellerListController controller;

  @override
  void initState() {
    controller = Get.put(SellerListController());
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
                      "Seller List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Seller List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.data != null)
                            PaginatedDataTable(
                              header: Padding(
                                padding: MySpacing.top(16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText.titleMedium(
                                          "Sellers",
                                          fontWeight: 600,
                                        ),
                                        MyContainer(
                                          onTap: () =>
                                              controller.gotoAddSeller(),
                                          paddingAll: 8,
                                          color: contentTheme.primary,
                                          child: Row(
                                            children: [
                                              Icon(
                                                LucideIcons.plus,
                                                size: 20,
                                                color: contentTheme.onPrimary,
                                              ),
                                              MySpacing.width(8),
                                              MyText.bodyMedium(
                                                "Add a new seller",
                                                color: contentTheme.onPrimary,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              source: controller.data!,
                              columns: [
                                DataColumn(
                                    label: MyText.bodyMedium('Customer Name',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Email',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Phone',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Orders',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Total Orders',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Customer Since',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Status',
                                        fontWeight: 600)),
                                DataColumn(
                                    label: MyText.bodyMedium('Action',
                                        fontWeight: 600)),
                              ],
                              columnSpacing: 75,
                              horizontalMargin: 50,
                              rowsPerPage: 10,
                              dataRowMaxHeight: 60,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyData extends DataTableSource with UIMixin {
  List<CustomersList> orderList = [];

  MyData(this.orderList);

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orderList.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    CustomersList customer = orderList[index];

    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            MyContainer.rounded(
              paddingAll: 0,
              height: 40,
              width: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(Images.avatars[index % Images.avatars.length]),
            ),
            MySpacing.width(8),
            MyText.bodyMedium(customer.customerName),
          ],
        )),
        DataCell(MyText.bodyMedium(customer.email)),
        DataCell(MyText.bodyMedium(customer.phone)),
        DataCell(MyText.bodyMedium(customer.order.toString())),
        DataCell(MyText.bodyMedium(customer.totalOrders.toString())),
        DataCell(
          MyText.bodyMedium(
            Utils.getDateTimeStringFromDateTime(customer.customerSince),
          ),
        ),
        DataCell(
          MyContainer(
            padding: MySpacing.xy(12, 4),
            borderRadiusAll: 100,
            color: customer.status == 'Active'
                ? contentTheme.success.withAlpha(36)
                : customer.status == 'Block'
                    ? contentTheme.danger.withAlpha(36)
                    : null,
            child: MyText.bodyMedium(
              customer.status,
              fontWeight: 600,
              color: customer.status == 'Active'
                  ? contentTheme.success
                  : customer.status == 'Block'
                      ? contentTheme.danger
                      : null,
            ),
          ),
        ),
        DataCell(Row(
          children: [
            InkWell(
              onTap: () => gotoEditScreen(),
              child: Icon(LucideIcons.edit, size: 20),
            ),
            MySpacing.width(12),
            InkWell(
              onTap: () => gotoDetailScreen(),
              child: Icon(LucideIcons.eye, size: 20),
            )
          ],
        ))
      ],
    );
  }

  void gotoDetailScreen() {
    Get.toNamed('/admin/sellers/detail');
  }

  void gotoEditScreen() {
    Get.toNamed('/admin/sellers/edit');
  }
}
