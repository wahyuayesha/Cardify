import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/const/gradients.dart';
import 'package:cardify/core/widgets/primary_button.dart';
import 'package:cardify/features/flashcard/presentation/pages/home_page.dart';
import 'package:cardify/features/main/presentation/pages/main_page.dart';
import 'package:cardify/features/onboard/presentation/controller/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final controller = PageController(initialPage: 0);
  final OnboardController onboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [cardIntro(), studyIntro()],
      ),
    );
  }

  Widget cardIntro() {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(gradient: AppGradients.background)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/decoration/intoduction1.png',
                scale: 3.8,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Stack(
                  children: [
                    // Container transparan
                    Container(
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        border: Border.all(color: AppColors.borderTrans),
                        color: AppColors.fillTrans,
                      ),
                    ),
                    // Container putih
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: Container(
                        height: 226,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.baseLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                'Flashcard Maker',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.baseDark,
                                ),
                              ),
                              Text(
                                'Simply add your notes, we’ll transform them into flashcards instantly!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.subtitle,
                                ),
                              ),
                              const Spacer(),
                              PrimaryButton(
                                width: 200,
                                onPressed: () {
                                  controller.nextPage(
                                    duration: Duration(seconds: 2),
                                    curve: Curves.bounceOut,
                                  );
                                },
                                text: 'Next',
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }

  Widget studyIntro() {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(gradient: AppGradients.background)),

        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/decoration/intoduction3.png',
                scale: 3.8,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Stack(
                  children: [
                    // Container transparan
                    Container(
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        border: Border.all(color: AppColors.borderTrans),
                        color: AppColors.fillTrans,
                      ),
                    ),
                    // Container putih
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: Container(
                        height: 226,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.baseLight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Text(
                                'Study Smarter',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.baseDark,
                                ),
                              ),
                              Text(
                                'Learn with ease through personalized flashcards designed to help you study anywhere, anytime.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.subtitle,
                                ),
                              ),
                              const Spacer(),
                              PrimaryButton(
                                width: 200,
                                onPressed: () async {
                                  // Set bahwa user sudah tidak first time buka aplikasi
                                  await onboardController
                                      .setNotFirstTimeUsecase()
                                      .then((_) {
                                        Get.off(
                                          HomePage(),
                                          transition: Transition.cupertino,
                                        );
                                      });
                                },
                                text: 'Get Started',
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}
