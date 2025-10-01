import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/flashcard/presentation/pages/home_page.dart';
import 'package:cardify/features/generate_flashcard/presentation/controllers/generate_controller.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PastePage extends StatelessWidget {
  PastePage({super.key});

  final ThemeController themeController = Get.find();
  final GenerateController generateController = Get.find();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // biar body ngikutin keyboard
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: themeController.isDark.value
                ? AppColors.baseLight
                : AppColors.primary,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Paste Text',
          style: TextStyle(
            color: themeController.isDark.value
                ? AppColors.baseLight
                : AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(
            () => Container(
              decoration: BoxDecoration(
                gradient: themeController.isDark.value
                    ? AppGradients.backgroundDark
                    : AppGradients.background,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              top: 100,
              bottom: 0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/decoration/text_header.png',
                      scale: 4,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Paste Your Notes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: themeController.isDark.value
                          ? AppColors.fourth
                          : AppColors.primary,
                    ),
                  ),
                  Text(
                    'Paste your study material, notes, or text you want to convert into flashcards',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: AppColors.baseLight),
                  ),
                  SizedBox(height: 50),

                  Stack(
                    children: [
                      // Container transparan
                      Container(
                        height: 360,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(39),
                          border: Border.all(color: AppColors.borderTrans),
                          color: AppColors.fillTrans,
                        ),
                      ),
                      // Container layer 2
                      Padding(
                        padding: const EdgeInsets.all(17),
                        child: Container(
                          height: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 200, // tinggi fixed
                                  child: TextField(
                                    controller: textController,
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    keyboardType: TextInputType.multiline,
                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.baseDark.withOpacity(
                                        0.1,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    scrollPhysics:
                                        BouncingScrollPhysics(), // bissa discroll
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      // color: themeController.isDark.value
                                      //     ? AppColors.subtitle
                                      //     : AppColors.subtitleLight,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Minimum 100 characters',
                                      style: TextStyle(
                                        // color: themeController.isDark.value
                                        //     ? AppColors.subtitle
                                        //     : AppColors.subtitleLight,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Obx(() {
                                  if (generateController.isLoading.value) {
                                    return LoadingAnimationWidget.staggeredDotsWave(
                                      color: AppColors.primary,
                                      size: 40,
                                    );
                                  } else {
                                    return PrimaryButton(
                                      width: 200,
                                      onPressed: () async {
                                        await generateController
                                            .createFlashcard(
                                              content: textController.text
                                                  .trim(),
                                            );
                                        textController.clear();
                                        if (generateController
                                            .successMessage
                                            .isNotEmpty) {
                                          Get.to(MainPage());
                                        }
                                      },
                                      text: 'Create Flashcards',
                                      prefixIcon: Icons.auto_fix_high,
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
