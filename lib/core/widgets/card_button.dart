import 'package:cardify/core/const/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardButton extends StatelessWidget {
  double height;
  Gradient gradient;
  String title;
  String desc;
  Widget icon;
  VoidCallback onPressed;

  CardButton({
    super.key,
    required this.height,
    required this.gradient,
    required this.title,
    required this.desc,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: gradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.fillTrans,
                  border: Border.all(color: AppColors.borderTrans),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: icon,
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.baseLight,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.baseLight.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.navigate_next_rounded,
                size: 30,
                color: AppColors.baseLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
