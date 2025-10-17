import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/functions/time_converter.dart';
import 'package:cardify/core/widgets/category_pill.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/flashcard/presentation/pages/detail_page.dart';
import 'package:cardify/features/generate_flashcard/presentation/pages/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FlashcardsPage extends StatelessWidget {
  FlashcardsPage({super.key});
  final FlashcardController flashcardController = Get.find();
  final ThemeController themeController = Get.find();

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            Text(
              'flashcard.title'.tr,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 5),
            Obx(
              () => Text(
                flashcardController.userPacks.length.toString(),
                style: TextStyle(
                  color: themeController.isDark.value
                      ? AppColors.subtitleLight
                      : AppColors.subtitle,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        // Tombol
        actions: [
          // filter
          Container(
            height: 40,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: flashcardController.sortBy.value,
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  icon: Icon(Icons.filter_list, color: AppColors.primary),
                  hint: Text(
                    'Filter',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  items: ['created', 'title', 'category'].map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      flashcardController.sortBy.value = value;
                      flashcardController.getUserFlashcards();
                    }
                  },
                ),
              ),
            ),
          ),

          SizedBox(width: 10),
          // search
          Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.search, color: AppColors.primary),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Text(
                      'flashcard.search'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: AppColors.primary,
                      ),
                    ),
                    content: TextField(
                      controller: searchController,
                      onChanged: (value) async {
                        flashcardController.keywords.value = value;
                        await flashcardController.getUserFlashcards();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.baseDark.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Obx(() {
        if (flashcardController.userPacks.isEmpty) {
          // JIKA TIDAK ADA PACK
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/decoration/empty.png', scale: 2.5),
                SizedBox(height: 20),
                Text(
                  'flashcard.emptySub'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'flashcard.emptyDesc'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeController.isDark.value
                          ? AppColors.subtitleLight
                          : AppColors.subtitle,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  onPressed: () {
                    Get.to(PhotoPage(), transition: Transition.cupertino);
                  },
                  text: 'button.create'.tr,
                  width: 160,
                  height: 40,
                ),
              ],
            ),
          );
        } else {
          // JIKA ADA PACK
          return ListView.builder(
            itemCount: flashcardController.userPacks.length,
            itemBuilder: (context, index) {
              final pack = flashcardController.userPacks[index];
              // Card Tile
              return GestureDetector(
                onTap: () => Get.to(DetailPage(cardPack: pack)),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        // Detail pack
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // judul
                              Text(
                                pack.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // deskripsi
                              Text(
                                pack.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: themeController.isDark.value
                                      ? AppColors.subtitleLight
                                      : AppColors.subtitle,
                                ),
                              ),
                              SizedBox(height: 10),
                              // kategori
                              CategoryPill(
                                category: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  pack.category,
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
                        // dekorasi
                        Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // waktu dibuat
                            Text(
                              convertTime(pack.createdAt),
                              style: TextStyle(
                                fontSize: 12,
                                color: themeController.isDark.value
                                    ? AppColors.subtitleLight
                                    : AppColors.subtitle,
                              ),
                            ),
                            // ikon pack
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                                gradient: AppGradients.category,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AppSvgIcon(
                                'assets/icons/flashcards.svg',
                                color: AppColors.baseLight,
                                size: 10,
                                fit: BoxFit.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
