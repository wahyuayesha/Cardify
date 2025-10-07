// ignore_for_file: deprecated_member_use

import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/card_button.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/generate_flashcard/presentation/controllers/generate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PhotoPage extends StatelessWidget {
  PhotoPage({super.key});

  final GenerateController generateController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Photo Notes',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 100,
          bottom: 25,
        ),
        child: Column(
          children: [
            SizedBox(height: 2),
            // Gambar
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/decoration/picture_header.png',
                scale: 4,
              ),
            ),
            SizedBox(height: 10),

            // Deskripsi
            Text(
              'Select Image Source',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Text(
                'Take a photo or select an image from your gallery to create a new flashcard.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: themeController.isDark.value
                      ? AppColors.subtitleLight
                      : AppColors.subtitle,
                ),
              ),
            ),
            Spacer(),

            // Tombol Kamera
            Obx(() {
              if (generateController.isLoading.value) {
                return Column(
                  children: [
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primary,
                      size: 60,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Generating your cards',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    CardButton(
                      height: 95,
                      gradient: AppGradients.maroonButton,
                      title: 'Take Picture',
                      desc: 'Use camera to take your note photo',
                      icon: Icon(
                        Icons.camera_alt_rounded,
                        color: AppColors.baseLight,
                      ),
                      onPressed: () async {
                        await generateController.pickImage(ImageSource.camera);
                        await generateController.createFlashcard();
                      },
                    ),
                    SizedBox(height: 25),

                    // Tombol Galeri
                    CardButton(
                      height: 95,
                      gradient: AppGradients.yellowButton,
                      title: 'Choose From Gallery',
                      desc: 'Upload your note image from storage ',
                      icon: Icon(Icons.photo, color: AppColors.baseLight),
                      onPressed: () async {
                        await generateController.pickImage(ImageSource.gallery);
                        await generateController.createFlashcard();
                      },
                    ),
                  ],
                );
              }
            }),
            Spacer(),
            // Container tips
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.category.withOpacity(0.2),
                border: Border.all(color: AppColors.category),
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
                        Icon(Icons.lightbulb, color: AppColors.category),
                        SizedBox(width: 5),
                        Text(
                          'Tips for best results',
                          style: TextStyle(
                            color: AppColors.category,
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
                          'Make sure the image is not blurry',
                          style: TextStyle(
                            color: AppColors.category,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          'Use proper lighting',
                          style: TextStyle(
                            color: AppColors.category,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          'Avoid shadows on text or objects',
                          style: TextStyle(
                            color: AppColors.category,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
