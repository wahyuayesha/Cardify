import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final VoidCallback onPressed;
  final String text;
  final IconData? prefixIcon;

  const PrimaryButton({
    Key? key,
    required this.width,
    required this.onPressed,
    required this.text,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, color: AppColors.baseLight),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(fontSize: 15, color: AppColors.baseLight),
            ),
          ],
        ),
      ),
    );
  }
}
