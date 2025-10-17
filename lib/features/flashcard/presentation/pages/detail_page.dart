// ignore_for_file: deprecated_member_use

import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/functions/time_converter.dart';
import 'package:cardify/core/widgets/category_pill.dart';
import 'package:cardify/core/widgets/dialog.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/flashcard/presentation/pages/study_page.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.cardPack});
  final FlashcardController flashcardController = Get.find();
  final ThemeController themeController = Get.find();
  PackEntity cardPack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'detail.title'.tr,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // BACKGROUND GRADIENT
          Container(
            decoration: BoxDecoration(gradient: AppGradients.background),
          ),

          // KONTEN UTAMA
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar header
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 30),
                child: Center(
                  child: Image.asset(
                    'assets/images/decoration/pack_header.png',
                    scale: 5,
                  ),
                ),
              ),

              // BAGIAN PUTIH
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            // BAGIAN INFORMASI PACK (JUDUL, DESKRIPSI, KATEGORI dll)
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Judul
                                    Expanded(
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        cardPack.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    // Waktu pembuatan pack
                                    Text(
                                      convertTime(cardPack.createdAt),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: themeController.isDark.value
                                            ? AppColors.subtitleLight
                                            : AppColors.subtitle,
                                      ),
                                    ),
                                  ],
                                ),
                                // Deskripsi
                                Text(
                                  cardPack.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: themeController.isDark.value
                                        ? AppColors.subtitleLight
                                        : AppColors.subtitle,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Pill Kategori
                                CategoryPill(
                                  category: Text(
                                    cardPack.category,
                                    style: TextStyle(
                                      color: AppColors.category,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                // CONTAINER INFO JUMLAH FLAG & KARTU
                                SizedBox(height: 20),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: AppGradients.infoContainer,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        // Jumlah Flag
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.fillTrans,
                                              border: Border.all(
                                                color: AppColors.borderTrans,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10),
                                                Icon(
                                                  Icons.flag_rounded,
                                                  color: AppColors.baseLight,
                                                ),
                                                SizedBox(width: 5),
                                                Obx(
                                                  () => Text(
                                                    '${flashcardController.getFlaggedCountForPackById(cardPack.id)} ${'text.flags'.tr}',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.baseLight,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Jumlah Kartu
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.fillTrans,
                                              border: Border.all(
                                                color: AppColors.borderTrans,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 10),
                                                AppSvgIcon(
                                                  'assets/icons/flashcards.svg',
                                                  color: AppColors.baseLight,
                                                  size: 18,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${cardPack.flashcards.length} ${'text.cards'.tr}',
                                                  style: TextStyle(
                                                    color: AppColors.baseLight,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
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

                                // TEKS MENTAH
                                SizedBox(height: 10),
                                Text(
                                  'detail.sub'.tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.baseDark.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        cardPack.origin,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // BOTTOM BUTTONS SECTION
                        // Button Delete
                        SizedBox(height: 20),
                        Row(
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                              onTap: () {
                                // Tampilkan dialog
                                Get.dialog(
                                  MyDialog(
                                    title: 'dialog.title'.tr,
                                    message:
                                        "dialog.sub".tr,
                                    confirmText: 'dialog.confirm'.tr,
                                    onConfirm: () async {
                                      await flashcardController
                                          .deleteFlashcardsPack(cardPack.id)
                                          .then((_) {
                                            Get.offAll(MainPage());
                                          });
                                    },
                                  ),
                                );
                              },
                            ),

                            // Button study
                            SizedBox(width: 10),
                            Expanded(
                              child: PrimaryButton(
                                height: 55,
                                borderRadius: 18,
                                onPressed: () {
                                  Get.to(StudyPage(cardPack: cardPack));
                                },
                                text: 'button.study'.tr,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
