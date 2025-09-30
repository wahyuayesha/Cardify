import 'package:cardify/core/const/colors.dart';
import 'package:cardify/core/widgets/svg_icon.dart';
import 'package:cardify/features/flashcard/presentation/pages/badges_page.dart';
import 'package:cardify/features/flashcard/presentation/pages/flashcards_page.dart';
import 'package:cardify/features/flashcard/presentation/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    FlashcardsPage(),
    BadgesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.baseDark.withOpacity(0.2),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: AppSvgIcon('assets/icons/home.svg'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: AppSvgIcon('assets/icons/flashcards.svg'),
              label: 'Flashcards',
            ),
            BottomNavigationBarItem(
              icon: AppSvgIcon('assets/icons/achievment.svg'),
              label: 'Badges',
            ),
          ],
        ),
      ),

      body: _pages[_selectedIndex],
    );
  }
}
