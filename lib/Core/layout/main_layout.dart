import 'package:flutter/material.dart';
import 'package:srws_app/features/home/presentation/pages/home_screen.dart';
import 'package:srws_app/features/history/presentation/pages/history_screen.dart';
import 'package:srws_app/features/guide/presentation/pages/guide_screen.dart';
import 'package:srws_app/features/setting/presentation/pages/settings_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const HistoryScreen(),
    const HomeScreen(),
    const GuideScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color appThemeColor = Color.fromARGB(255, 49, 151, 52);

    return Scaffold(
      backgroundColor: appThemeColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: appThemeColor,
            unselectedItemColor: Colors.grey.shade400,
            showUnselectedLabels: true,
            selectedFontSize: 13,
            unselectedFontSize: 11,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.recycling_rounded),
                activeIcon: Icon(Icons.recycling),
                label: 'Sorting',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                activeIcon: Icon(Icons.menu_book),
                label: 'Guide',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}