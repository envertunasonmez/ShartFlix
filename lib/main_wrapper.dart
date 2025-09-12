import 'package:flutter/material.dart';
import 'package:jr_case_boilerplate/core/constants/app_colors.dart';
import '../../features/home/view/home_view.dart';
import '../../features/profile/view/profile_view.dart';
import '../core/widgets/nav_bar/custom_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  static const double _navBarHeight = 72;

  List<Widget> get _pages => [
    Padding(
      padding: const EdgeInsets.only(bottom: _navBarHeight + 16),
      child: const HomeView(),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: _navBarHeight + 16),
      child: const ProfileView(),
    ),
  ];

  void _onTap(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: CustomNavBar(currentIndex: _currentIndex, onTap: _onTap),
          ),
        ],
      ),
    );
  }
}
