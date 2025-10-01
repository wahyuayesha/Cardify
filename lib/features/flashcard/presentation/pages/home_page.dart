import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/card_button.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/generate_flashcard/presentation/pages/paste_page.dart';
import 'package:cardify/features/generate_flashcard/presentation/pages/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      height: 80,
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
                                  'Total Card Packs Created',
                                  style: TextStyle(color: AppColors.baseLight),
                                ),
                                Text(
                                  '000',
                                  style: TextStyle(
                                    color: AppColors.baseLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ), // TODO: Menggunakan data asli
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
                          title: 'Photo Notes',
                          desc: 'Snap or upload & convert to cards',
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
                          title: 'Paste Text',
                          desc: 'Convert text to\ncards',
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
                    title: 'My Card Packs',
                    desc: 'View All Collections',
                    icon: AppSvgIcon(
                      'assets/icons/flashcards.svg',
                      fit: BoxFit.none,
                      color: AppColors.baseLight,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 35),

                  // Recent Card Packs Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Card Packs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // TODO: Implemen data asli
                  Container(height: 330, color: AppColors.baseLight),
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
                  const Text(
                    'Settings',
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
                          'Theme',
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
              transBar(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.translate, color: AppColors.baseLight),
                      const SizedBox(width: 5),
                      Text(
                        'Language',
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
              SizedBox(height: 15),
              // Bar donasi
              transBar(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.coffee_rounded, color: AppColors.baseLight),
                      const SizedBox(width: 5),
                      Text(
                        'Buy me a coffee',
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
