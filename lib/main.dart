import 'package:cardify/features/flashcard/presentation/controller/theme_controller.dart';
import 'package:cardify/features/splash/presentation/pages/splash_page.dart';
import 'package:cardify/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.theme,
        home: SplashPage(),
      ),
    );
  }
}
