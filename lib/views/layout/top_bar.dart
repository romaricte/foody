import 'package:flutter/material.dart';
import 'package:myfoody/helpers/localizations/language.dart';
import 'package:myfoody/helpers/theme/app_notifire.dart';
import 'package:myfoody/helpers/theme/app_style.dart';
import 'package:myfoody/helpers/theme/app_themes.dart';
import 'package:myfoody/helpers/theme/theme_customizer.dart';
import 'package:myfoody/helpers/utils/my_shadow.dart';
import 'package:myfoody/helpers/utils/ui_mixins.dart';
import 'package:myfoody/helpers/widgets/my_button.dart';
import 'package:myfoody/helpers/widgets/my_card.dart';
import 'package:myfoody/helpers/widgets/my_container.dart';
import 'package:myfoody/helpers/widgets/my_dashed_divider.dart';
import 'package:myfoody/helpers/widgets/my_spacing.dart';
import 'package:myfoody/helpers/widgets/my_text.dart';
import 'package:myfoody/helpers/widgets/my_text_style.dart';
import 'package:myfoody/images.dart';
import 'package:myfoody/views/auth/login_screen.dart';
import 'package:myfoody/widgets/custom_pop_menu.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      shadow: MyShadow(position: MyShadowPosition.bottomRight, elevation: 0.5),
      height: 60,
      borderRadiusAll: 0,
      padding: MySpacing.x(24),
      color: topBarTheme.background.withAlpha(246),
      child: Row(
        children: [
          Row(
            children: [
              InkWell(
                  splashColor: theme.colorScheme.onBackground,
                  highlightColor: theme.colorScheme.onBackground,
                  onTap: () {
                    ThemeCustomizer.toggleLeftBarCondensed();
                  },
                  child: Icon(
                    LucideIcons.menu,
                    color: topBarTheme.onBackground,
                  )),
              MySpacing.width(24),
              SizedBox(
                width: 200,
                child: TextFormField(
                  maxLines: 1,
                  style: MyTextStyle.bodyMedium(),
                  decoration: InputDecoration(
                      hintText: "search",
                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            LucideIcons.search,
                            size: 14,
                          )),
                      prefixIconConstraints: const BoxConstraints(
                          minWidth: 36,
                          maxWidth: 36,
                          minHeight: 32,
                          maxHeight: 32),
                      contentPadding: MySpacing.xy(16, 12),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    ThemeCustomizer.setTheme(
                        ThemeCustomizer.instance.theme == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark);
                  },
                  child: Icon(
                    ThemeCustomizer.instance.theme == ThemeMode.dark
                        ? LucideIcons.sun
                        : LucideIcons.moon,
                    size: 18,
                    color: topBarTheme.onBackground,
                  ),
                ),
                MySpacing.width(12),
                CustomPopupMenu(
                  backdrop: true,
                  hideFn: (value) => languageHideFn = value,
                  onChange: (value) {},
                  offsetX: -36,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Center(
                      child: ClipRRect(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadius: BorderRadius.circular(2),
                        child: Image.asset(
                          "assets/lang/${ThemeCustomizer.instance.currentLanguage.locale.languageCode}.jpg",
                          width: 24,
                          height: 18,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  menuBuilder: (context) => buildLanguageSelector(),
                ),
                MySpacing.width(6),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (value) {},
                  offsetX: -120,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: const Center(
                      child: Icon(
                        LucideIcons.bell,
                        size: 18,
                      ),
                    ),
                  ),
                  menuBuilder: (context) => buildNotifications(),
                ),
                MySpacing.width(4),
                CustomPopupMenu(
                  backdrop: true,
                  onChange: (value) {},
                  offsetX: -60,
                  offsetY: 8,
                  menu: Padding(
                    padding: MySpacing.xy(8, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyContainer.rounded(
                            paddingAll: 0,
                            child: Image.asset(
                              Images.avatars[0],
                              height: 28,
                              width: 28,
                              fit: BoxFit.cover,
                            )),
                        MySpacing.width(8),
                        MyText.labelLarge("Romaric")
                      ],
                    ),
                  ),
                  menuBuilder: (context) => buildAccountMenu(),
                  hideFn: (value) => languageHideFn = value,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLanguageSelector() {
    return MyContainer.bordered(
      padding: MySpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Language.languages
            .map((language) => MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () async {
                    languageHideFn?.call();
                    // Language.changeLanguage(language);
                    await Provider.of<AppNotifier>(context, listen: false)
                        .changeLanguage(language, notify: true);
                    ThemeCustomizer.notify();
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(
                            "assets/lang/${language.locale.languageCode}.jpg",
                            width: 16,
                            height: 16,
                            fit: BoxFit.cover,
                          )),
                      MySpacing.width(8),
                      MyText.labelMedium(language.languageName)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildNotifications() {
    List<Widget> notifications = [];
    for (int i = 0; i < 6; i++) {
      notifications.add(buildNotification(
          "New Update", "Flutter 3.10 has been launched"));
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText.titleMedium("Notifications", fontWeight: 600),
                MyText.bodySmall("3 Unread")
              ],
            ),
          ),
          const MyDashedDivider(height: 1),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              children: notifications,
            ),
          ),
          const MyDashedDivider(height: 1),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  padding: MySpacing.zero,
                  onPressed: () {},
                  splashColor: contentTheme.secondary.withAlpha(28),
                  child: MyText.bodySmall(
                    "View All",
                    color: contentTheme.secondary,
                  ),
                ),
                MyButton.text(
                  padding: MySpacing.zero,
                  onPressed: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: MyText.bodySmall(
                    "Clear",
                    color: contentTheme.danger,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildNotification(String title, String description) {
    return Padding(
      padding: MySpacing.bottom(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.none(
            borderRadiusAll: 4,
            paddingAll: 8,
            color: contentTheme.primary.withAlpha(20),
            child: Icon(
              LucideIcons.mail,
              size: 16,
              color: contentTheme.primary,
            ),
          ),
          MySpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600),
                MyText.bodySmall(description),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.user,
                        size: 14,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("My Profile")
                    ],
                  ),
                ),
                MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.mail,
                        size: 14,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("Inbox")
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MyDashedDivider(height: 1),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.settings,
                        size: 14,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("Settings")
                    ],
                  ),
                ),
                MyButton.text(
                  padding: MySpacing.xy(8, 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  splashColor: contentTheme.onBackground.withAlpha(20),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.lock,
                        size: 14,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("Lock Screen")
                    ],
                  ),
                ),
              ],
            ),
          ),
          const MyDashedDivider(height: 1),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton.text(
              padding: MySpacing.xy(8, 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashColor: contentTheme.danger.withAlpha(20),
              onPressed: () {
                Get.offAll(() => const LoginScreen());
              },
              child: Row(
                children: [
                  Icon(
                    LucideIcons.logOut,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log Out",
                    color: contentTheme.danger,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
