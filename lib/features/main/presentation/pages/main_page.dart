// ignore_for_file: deprecated_member_use

// import 'package:cardify/core/const/colors.dart';
// import 'package:cardify/core/widgets/svg_icon.dart';
// import 'package:cardify/features/flashcard/presentation/pages/badges_page.dart';
// import 'package:cardify/features/flashcard/presentation/pages/flashcards_page.dart';
// import 'package:cardify/features/flashcard/presentation/pages/home_page.dart';
// import 'package:cardify/features/main/presentation/controller/navbar_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   final NavbarController navbarController = Get.find();
//   final List<Widget> pages = [HomePage(), FlashcardsPage(), BadgesPage()];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               top: BorderSide(color: Theme.of(context).dividerColor),
//             ),
//           ),
//           child: BottomNavigationBar(
//             currentIndex: navbarController.selectedIndex.value,
//             onTap: navbarController.setOnItemTaped,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             selectedItemColor: AppColors.primary,
//             unselectedItemColor: AppColors.baseDark.withOpacity(0.2),
//             showUnselectedLabels: false,
//             showSelectedLabels: false,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: AppSvgIcon('assets/icons/home.svg'),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: AppSvgIcon('assets/icons/flashcards.svg'),
//                 label: 'Flashcards',
//               ),
//               BottomNavigationBarItem(
//                 icon: AppSvgIcon('assets/icons/achievment.svg'),
//                 label: 'Badges',
//               ),
//             ],
//           ),
//         ),
//         body: pages[navbarController.selectedIndex.value],
//       ),
//     );
//   }
// }
