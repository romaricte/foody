import 'package:flutter/material.dart';
import 'package:foody/controller/ui/seller/add_seller_controller.dart';
import 'package:foody/helpers/utils/ui_mixins.dart';
import 'package:foody/helpers/widgets/my_breadcrumb.dart';
import 'package:foody/helpers/widgets/my_breadcrumb_item.dart';
import 'package:foody/helpers/widgets/my_container.dart';
import 'package:foody/helpers/widgets/my_flex.dart';
import 'package:foody/helpers/widgets/my_flex_item.dart';
import 'package:foody/helpers/widgets/my_spacing.dart';
import 'package:foody/helpers/widgets/my_text.dart';
import 'package:foody/helpers/widgets/my_text_style.dart';
import 'package:foody/helpers/widgets/responsive.dart';
import 'package:foody/views/layout/layout.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AddSellerScreen extends StatefulWidget {
  const AddSellerScreen({super.key});

  @override
  State<AddSellerScreen> createState() => _AddSellerScreenState();
}

class _AddSellerScreenState extends State<AddSellerScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddSellerController controller;

  @override
  void initState() {
    controller = Get.put(AddSellerController());
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
                      "Add Seller",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Admin'),
                        MyBreadcrumbItem(name: 'Add Seller', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyContainer(
                  padding: MySpacing.xy(20, 20),
                  child: Column(
                    children: [
                      MyFlex(
                        children: [
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              'First Name',
                              "Enter First Name",
                            ),
                          ),
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              "Last Name",
                              "Enter Last Name",
                            ),
                          ),
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              'User Name',
                              "Enter User Name",
                            ),
                          ),
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              "Email",
                              "Enter Email",
                            ),
                          ),
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              'Phone Number',
                              "Enter Phone Number",
                            ),
                          ),
                          MyFlexItem(
                              sizes: "md-6 sm-12",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "Country",
                                  ),
                                  MySpacing.height(8),
                                  DropdownButtonFormField<Country>(
                                    dropdownColor: contentTheme.background,
                                    isDense: true,
                                    items: Country.values
                                        .map(
                                          (category) =>
                                              DropdownMenuItem<Country>(
                                            value: category,
                                            child: MyText.labelMedium(
                                              category.name.capitalize!,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    icon: Icon(
                                      LucideIcons.chevronDown,
                                      size: 20,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Select Country",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(12),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                    onChanged: controller.basicValidator
                                        .onChanged<Object?>(
                                      'Country',
                                    ),
                                  )
                                ],
                              )),
                          MyFlexItem(
                              sizes: "md-6 sm-12",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "State",
                                  ),
                                  MySpacing.height(8),
                                  DropdownButtonFormField<StateName>(
                                    dropdownColor: contentTheme.background,
                                    isDense: true,
                                    items: StateName.values
                                        .map(
                                          (category) =>
                                              DropdownMenuItem<StateName>(
                                            value: category,
                                            child: MyText.labelMedium(
                                              category.name.capitalize!,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    icon: Icon(
                                      LucideIcons.chevronDown,
                                      size: 20,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Select State",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(12),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                    onChanged: controller.basicValidator
                                        .onChanged<Object?>(
                                      'State',
                                    ),
                                  )
                                ],
                              )),
                          MyFlexItem(
                            sizes: "md-6 sm-12",
                            child: buildTextField(
                              'Zip Code',
                              "Enter Zip Code",
                            ),
                          ),
                          MyFlexItem(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.labelMedium(
                                  "Description",
                                ),
                                MySpacing.height(8),
                                TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "It's contains blah blah things",
                                    hintStyle:
                                        MyTextStyle.bodySmall(xMuted: true),
                                    border: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    focusedBorder: focusedInputBorder,
                                    contentPadding: MySpacing.all(16),
                                    isCollapsed: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      MySpacing.height(12),
                      Padding(
                        padding: MySpacing.right(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyContainer.bordered(
                              paddingAll: 8,
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(LucideIcons.x, size: 20),
                                  MySpacing.width(8),
                                  MyText.bodyMedium(
                                    "Close",
                                    fontWeight: 600,
                                  )
                                ],
                              ),
                            ),
                            MySpacing.width(12),
                            MyContainer(
                              paddingAll: 8,
                              onTap: () {},
                              color: contentTheme.primary.withAlpha(40),
                              child: Row(
                                children: [
                                  Icon(LucideIcons.save,
                                      size: 20, color: contentTheme.primary),
                                  MySpacing.width(8),
                                  MyText.bodyMedium("Save",
                                      fontWeight: 600,
                                      color: contentTheme.primary)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  buildTextField(
    String fieldTitle,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(
          fieldTitle,
        ),
        MySpacing.height(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}
