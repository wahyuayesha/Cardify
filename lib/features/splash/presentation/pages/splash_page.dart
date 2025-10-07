import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/features/flashcard/presentation/controller/flashcard_controller.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:cardify/features/onboard/presentation/controller/onboard_controller.dart';
import 'package:cardify/features/onboard/presentation/pages/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final OnboardController onboardController = Get.find();
  final FlashcardController flashcardController = Get.find();

  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    final start = DateTime.now();

    // TODO: Implementasi ambil semua data flashcards (mempersiapkan untuk menampilkan jumlah flashcards dan 3 flashcard terbaru di home )
    final isFirstTime = await onboardController.firstTimeStatus();
    await flashcardController.getUserFlashcards();
    await flashcardController.getRecentUserFlashcards();


    print('❔Is First Time = $isFirstTime');

    final elapsed = DateTime.now().difference(start);
    final remaining = Duration(seconds: 5) - elapsed;
    if (remaining > Duration.zero) {
      await Future.delayed(remaining);
    }

    //pindah halaman home/intro tergantung apakah pertama kali buka aplikasi atau tidak
    if (isFirstTime == true) {
      Get.off(
        OnboardPage(),
        transition: Transition.fade,
        duration: Duration(seconds: 3),
      );
    } else {
      Get.off(
        MainPage(),
        transition: Transition.fade,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: AppGradients.splash)),
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/decoration/logo.png', scale: 4),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: AppColors.baseLight,
                rightDotColor: AppColors.baseLight,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
