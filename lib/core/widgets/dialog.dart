import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback onConfirm;

  const MyDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      icon: Icon(Icons.warning, color: AppColors.primary),
      title: Text(
        title,
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
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeController.isDark.value
                  ? AppColors.subtitleLight
                  : AppColors.subtitle,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Get.back(),
                  text: 'Cancel',
                  borderRadius: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: PrimaryButton(
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                  text: confirmText,
                  borderRadius: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
