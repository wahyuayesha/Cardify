import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onPressed;
  final String text;
  final double? borderRadius;
  final IconData? prefixIcon;

  const PrimaryButton({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?? 150,
      height: height?? 50,
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(borderRadius ?? 50),
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
