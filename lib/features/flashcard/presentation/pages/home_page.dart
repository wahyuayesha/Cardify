import 'dart:math';

import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/config.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/functions/time_converter.dart';
import 'package:cardify/core/widgets/card_button.dart';
import 'package:cardify/core/widgets/category_pill.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/language_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/time_controller.dart';
import 'package:cardify/features/flashcard/presentation/pages/detail_page.dart';
import 'package:cardify/features/flashcard/presentation/pages/flashcards_page.dart';
import 'package:cardify/features/generate_flashcard/presentation/pages/paste_page.dart';
import 'package:cardify/features/generate_flashcard/presentation/pages/photo_page.dart';
import 'package:cardify/features/main/presentation/controller/navbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FlashcardController flashcardController = Get.find();
  final ThemeController themeController = Get.find();
  final TimeController timeController = Get.find();
  final NavbarController navbarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 200,
              decoration: BoxDecoration(gradient: AppGradients.header),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 25,
                  right: 25,
                  left: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/decoration/icon_horizontal.png',
                          scale: 3,
                        ),
                        Builder(
                          builder: (context) {
                            return IconButton(
                              color: AppColors.baseLight,
                              icon: const Icon(Icons.settings_rounded),
                              onPressed: () {
                                Scaffold.of(
                                  context,
                                ).openDrawer(); // ✅ sekarang bisa
                              },
                            );
                          },
                        ),
                      ],
                    ),

                    // Container Total Card Packs
                    Container(
                      height: 82,
                      decoration: BoxDecoration(
                        color: AppColors.fillTrans,
                        border: Border.all(color: AppColors.borderTrans),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // informasi jumlah total
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'home.info'.tr,
                                  style: TextStyle(color: AppColors.baseLight),
                                ),
                                Obx(
                                  () => Text(
                                    flashcardController.recentPacks.length
                                        .toString(),
                                    style: TextStyle(
                                      color: AppColors.baseLight,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // ikon
                            Container(
                              height: 43,
                              width: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                              child: Icon(
                                Icons.electric_bolt,
                                color: AppColors.fourth,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Utama
            Padding(
              padding: EdgeInsetsGeometry.all(25),
              child: Column(
                children: [
                  // Tombol Photo & Paste
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            color: AppColors.baseLight,
                          ),
                          title: 'button.image'.tr,
                          desc: 'desc.image'.tr,
                          gradient: AppGradients.maroonButton,
                          onPressed: () {
                            Get.to(PhotoPage());
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: MyButton(
                          icon: AppSvgIcon(
                            'assets/icons/paste.svg',
                            size: 10,
                            fit: BoxFit.none,
                            color: AppColors.baseLight,
                          ),
                          title: 'button.paste'.tr,
                          desc: 'desc.paste'.tr,
                          gradient: AppGradients.yellowButton,
                          onPressed: () {
                            Get.to(PastePage());
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tombol Flashcard
                  CardButton(
                    height: 90,
                    gradient: AppGradients.flashcardButton,
                    title: 'button.card'.tr,
                    desc: 'desc.card'.tr,
                    icon: AppSvgIcon(
                      'assets/icons/flashcards.svg',
                      fit: BoxFit.none,
                      color: AppColors.baseLight,
                    ),
                    onPressed: () {
                      // navbarController.setOnItemTaped(1);
                      Get.to(FlashcardsPage());
                    },
                  ),
                  const SizedBox(height: 35),

                  // Recent Card Packs Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'home.sub'.tr,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Obx(() {
                    // jika flascard kosong
                    if (flashcardController.recentPacks.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          themeController.isDark.value
                              ? Image.asset(
                                  'assets/images/decoration/empty_dark.png',
                                  scale: 3,
                                )
                              : Image.asset(
                                  'assets/images/decoration/empty.png',
                                  scale: 3,
                                ),
                          SizedBox(height: 10),

                          Text(
                            'home.empty'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColors.subtitle,
                            ),
                          ),
                        ],
                      );
                    }

                    // jika berisi
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: min(3, flashcardController.recentPacks.length),
                      itemBuilder: (context, index) {
                        // CARD PACK TILE
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: GestureDetector(
                            onTap: () => Get.to(
                              DetailPage(
                                cardPack:
                                    flashcardController.recentPacks[index],
                              ),
                            ),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Judul card pack
                                          Text(
                                            flashcardController
                                                .recentPacks[index]
                                                .title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),

                                          // Deskripsi card pack
                                          Text(
                                            flashcardController
                                                .recentPacks[index]
                                                .description,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  themeController.isDark.value
                                                  ? AppColors.subtitleLight
                                                  : AppColors.subtitle,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Spacer(),

                                          // pill kategori
                                          CategoryPill(
                                            category: Text(
                                              flashcardController
                                                  .recentPacks[index]
                                                  .category,
                                              style: TextStyle(
                                                color: AppColors.category,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),

                                    // Waktu pembuatan & icon
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(() {
                                          final _ = timeController.now.value;

                                          return Text(
                                            convertTime(
                                              flashcardController
                                                  .recentPacks[index]
                                                  .createdAt,
                                            ),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  themeController.isDark.value
                                                  ? AppColors.subtitleLight
                                                  : AppColors.subtitle,
                                            ),
                                          );
                                        }),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            gradient: AppGradients.category,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: AppSvgIcon(
                                            'assets/icons/flashcards.svg',
                                            color: AppColors.baseLight,
                                            size: 15,
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        // CARD PACK TILE END
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final ThemeController themeController = Get.find();
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        decoration: BoxDecoration(gradient: AppGradients.background),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              // ikon settings
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.settings_rounded,
                    color: AppColors.baseLight,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'settings.title'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.baseLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Bar switch tema
              transBar(
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 3),
                  child: Obx(
                    () => Row(
                      children: [
                        themeController.isDark.value == true
                            ? Icon(Icons.dark_mode, color: AppColors.baseLight)
                            : Icon(
                                Icons.light_mode,
                                color: AppColors.baseLight,
                              ),
                        const SizedBox(width: 5),
                        Text(
                          'button.theme'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.baseLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Switch(
                          value: themeController.isDark.value,
                          onChanged: themeController.switchTheme,
                          activeThumbColor: AppColors.backgroundDark,
                          inactiveThumbColor: AppColors.primary,
                          trackOutlineWidth: WidgetStateProperty.all(0.0),
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Bar ubah bahasa
              Obx(
                () => transBar(
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Locale>(
                        isExpanded: true,
                        value: languageController.selectedLocale.value,
                        dropdownColor: AppColors.fillTrans, // biar senada
                        borderRadius: BorderRadius.circular(16),
                        items: languageController.daftarBahasa.map((bahasa) {
                          return DropdownMenuItem(
                            value: bahasa['locale'] as Locale,
                            child: Text(
                              bahasa['name'],
                              style: TextStyle(
                                color: AppColors
                                    .baseLight, // sesuaikan dengan tema kamu
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (locale) {
                          if (locale != null)
                            languageController.gantiBahasa(locale);
                        },
                        icon: Icon(
                          Icons.language_rounded,
                          color: AppColors.baseLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15),
              // Bar donasi
              transBar(
                GestureDetector(
                  onTap: () async {
                    const url = AppConfig.donationLink; 
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(
                        Uri.parse(url),
                        mode: LaunchMode
                            .externalApplication, // buka di browser eksternal
                      );
                    } else {
                      Get.snackbar('Error', 'Tidak bisa membuka tautan');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.coffee_rounded, color: AppColors.baseLight),
                        const SizedBox(width: 5),
                        Text(
                          'button.donation'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.baseLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget custom bar
  Widget transBar(Widget child) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.fillTrans,
        border: Border.all(color: AppColors.borderTrans),
        borderRadius: BorderRadius.circular(50),
      ),
      child: child,
    );
  }
}

class MyButton extends StatelessWidget {
  final Widget icon;
  final String title;
  final String desc;
  final Gradient gradient;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.gradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.fillTrans,
                  border: Border.all(color: AppColors.borderTrans),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.baseLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.baseLight.withOpacity(0.7),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
