import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/functions/time_converter.dart';
import 'package:cardify/core/widgets/category_pill.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          'Card Pack Details',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // background gradient
          Container(
            decoration: BoxDecoration(gradient: AppGradients.background),
          ),

          // main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // header image
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 30),
                child: Center(
                  child: Image.asset(
                    'assets/images/decoration/pack_header.png',
                    scale: 5,
                  ),
                ),
              ),

              // white section
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
                            // BAGIAN INFORMASI PACK
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
                                                Text(
                                                  '${cardPack.flashcards.where((c) => c.flag == 1).length} Flags',
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
                                                  '${cardPack.flashcards.length} Cards',
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
                                  'Original Notes',
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
                        // Button bawah
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
                                Get.dialog(
                                  AlertDialog(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    icon: Icon(
                                      Icons.warning,
                                      color: AppColors.primary,
                                    ),
                                    title: Text(
                                      'Delete this card pack?',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "You can't restore this card pack once already deleted",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: themeController.isDark.value
                                                ? AppColors.subtitleLight
                                                : AppColors.subtitle,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: PrimaryButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                text: 'Cancel',
                                                borderRadius: 18,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: PrimaryButton(
                                                onPressed: () async {
                                                  await flashcardController
                                                      .deleteFlashcardsPack(
                                                        cardPack.id,
                                                      )
                                                      .then((_) {
                                                        Get.offAll(MainPage());
                                                      });
                                                },
                                                text: flashcardController.isLoading? 'Deleting..' : 'Delete',
                                                borderRadius: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: PrimaryButton(
                                height: 55,
                                borderRadius: 18,
                                onPressed: () {},
                                text: 'Start Study',
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
