import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/card_button.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoPage extends StatelessWidget {
  PhotoPage({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(height: 2),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/decoration/picture_header.png',
                scale: 4,
              ),
            ),
            SizedBox(height: 10),
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
            CardButton(
              height: 95,
              gradient: AppGradients.maroonButton,
              title: 'Take Picture',
              desc: 'Use camera to take your note photo',
              icon: Icon(Icons.camera_alt_rounded, color: AppColors.baseLight),
              onPressed: () {},
            ),
            SizedBox(height: 25),
            CardButton(
              height: 95,
              gradient: AppGradients.yellowButton,
              title: 'Choose From Gallery',
              desc: 'Upload your note image from storage ',
              icon: Icon(Icons.photo, color: AppColors.baseLight),
              onPressed: () {},
            ),
            Spacer(),
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
