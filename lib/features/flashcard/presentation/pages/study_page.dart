// ignore_for_file: deprecated_member_use

import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/dialog.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/domain/entities/flashcard_entity.dart';
import 'package:cardify/features/flashcard/domain/entities/pack_entity.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/study_controller.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:get/get.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key, required this.cardPack});
  final PackEntity cardPack;

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  final StudyController studyController = Get.find();
  final ThemeController themeController = Get.find();
  final FlashcardController flashcardController = Get.find();

  late List<FlashcardEntity> cards;

  @override
  void initState() {
    super.initState();
    // salin data agar tidak ubah widget.cardPack langsung
    cards = List.from(widget.cardPack.flashcards);
  }

  void shuffleCards() {
    setState(() {
      cards.shuffle(); // built-in function untuk acak list
      studyController.kartuAktif.value = 0; // reset ke kartu pertama
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.cardPack.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (!themeController.isDark.value)
            Container(
              decoration: BoxDecoration(gradient: AppGradients.background),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),

                  // PROGRESS SECTION
                  child: Column(
                    children: [
                      // Informasi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.flag_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Obx(
                                () => Text(
                                  '${flashcardController.getFlaggedCountForPackById(widget.cardPack.id)} ${'text.flagged'.tr}',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Obx(
                            () => Text(
                              '${studyController.kartuAktif.value + 1}/${cards.length} ${'text.cards'.tr}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Bar Progress
                      Obx(() {
                        final progress = studyController.getProgress(
                          cards.length,
                        );
                        return TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: progress),

                          duration: const Duration(milliseconds: 500),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                                value: value,
                                minHeight: 10,
                                backgroundColor: AppColors.baseLight,
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                        );
                      }),
                    ],
                  ),
                ),

                // BAGIAN FLASHCARD
                Expanded(
                  child: PageView.builder(
                    itemCount: cards.length,
                    onPageChanged: (index) {
                      studyController.kartuAktif.value = index;
                    },
                    itemBuilder: (context, index) {
                      final controller = FlipCardController();
                      var card = cards[index];

                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              child: FlipCard(
                                controller: controller,
                                rotateSide: RotateSide.right,
                                axis: FlipAxis.vertical,
                                onTapFlipping: true,

                                // Card bagian depan (pertanyaan)
                                frontWidget: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  color: AppColors.fourth,
                                  elevation: 8,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.question_mark_rounded,
                                            color: AppColors.baseLight,
                                            size: 35,
                                          ),
                                          Text(
                                            card.front,
                                            style: const TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Obx(() {
                                              // ambil kartu dari reactive variabel agar widget bisa terupdate real time
                                              final flashcard =
                                                  flashcardController
                                                      .findCardById(card.id!);
                                              final isFlag =
                                                  flashcard?.flag == 1;

                                              return IconButton(
                                                onPressed: () =>
                                                    flashcardController
                                                        .toggleFlag(card.id!),
                                                icon: Icon(
                                                  Icons.flag_rounded,
                                                  size: 35,
                                                  color: isFlag
                                                      ? AppColors.baseLight
                                                      : AppColors.baseDark
                                                            .withOpacity(0.1),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // Card bagian belalang (jawaban)
                                backWidget: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  color: AppColors.primary,
                                  elevation: 8,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.question_answer,
                                            color: AppColors.baseLight,
                                            size: 35,
                                          ),
                                          Text(
                                            card.back,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Obx(() {
                                              // ambil kartu dari reactive variabel agar widget bisa terupdate real time
                                              final flashcard =
                                                  flashcardController
                                                      .findCardById(card.id!);
                                              final isFlag =
                                                  flashcard?.flag == 1;

                                              return IconButton(
                                                onPressed: () =>
                                                    flashcardController
                                                        .toggleFlag(card.id!),
                                                icon: Icon(
                                                  Icons.flag_rounded,
                                                  size: 35,
                                                  color: isFlag
                                                      ? AppColors.baseLight
                                                      : AppColors.baseDark
                                                            .withOpacity(0.1),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // BOTTOM AREA (CONTAINER TIPS & TOMBOL)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 25,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      // CONTAINER TIPS
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.baseLight.withOpacity(0.2),
                          border: Border.all(color: AppColors.baseLight),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb,
                                    color: AppColors.baseLight,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'notice1.title'.tr,
                                    style: TextStyle(
                                      color: AppColors.baseLight,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 30),
                                  Text(
                                    'notice1.content1'.tr,
                                    style: TextStyle(
                                      color: AppColors.baseLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 30),
                                  Text(
                                    'notice2.content2'.tr,
                                    style: TextStyle(
                                      color: AppColors.baseLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 30),
                                  Text(
                                    'notice3.content3'.tr,
                                    style: TextStyle(
                                      color: AppColors.baseLight,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // TOMBOL
                      SizedBox(height: 15),
                      Row(
                        children: [
                          // Tombol shuffle
                          // Tombol shuffle
                          Expanded(
                            child: GestureDetector(
                              onTap: shuffleCards, // 🔹 panggil fungsi acak
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: themeController.isDark.value
                                        ? AppColors.primary
                                        : AppColors.baseLight,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppSvgIcon(
                                      'assets/icons/flashcards.svg',
                                      color: themeController.isDark.value
                                          ? AppColors.primary
                                          : AppColors.baseLight,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'button.shuffle'.tr,
                                      style: TextStyle(
                                        color: themeController.isDark.value
                                            ? AppColors.primary
                                            : AppColors.baseLight,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Tombol Finish
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: themeController.isDark.value
                                      ? AppColors.primary
                                      : AppColors.baseLight,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'button.finish'.tr,
                                  style: TextStyle(
                                    color: !themeController.isDark.value
                                        ? AppColors.primary
                                        : AppColors.baseLight,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.dialog(
                                  MyDialog(
                                    title:
                                        'dialog1.title'.tr,
                                    message: '',
                                    confirmText: 'button.finish'.tr,
                                    onConfirm: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
