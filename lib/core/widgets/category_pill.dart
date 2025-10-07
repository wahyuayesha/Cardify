import 'package:cardify/core/const/colors.dart';
import 'package:flutter/widgets.dart';

class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.category});

  final Widget category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        color: AppColors.category.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [category],
        ),
      ),
    );
  }
}
