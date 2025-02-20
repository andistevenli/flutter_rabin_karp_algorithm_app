import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/about/about_screen.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/home/home_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(95.0),
      child: BottomNavigationBar(
        backgroundColor: ColorManager.WHITE,
        currentIndex: widget.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.BLACK,
        selectedLabelStyle: const TextStyle(
          fontSize: UnitManager.BODY_MEDIUM,
          backgroundColor: ColorManager.WHITE,
          color: ColorManager.BLACK,
          fontWeight: FontWeight.w500,
        ),
        unselectedItemColor: ColorManager.SECONDARY_COLOR,
        unselectedLabelStyle: const TextStyle(
          fontSize: UnitManager.BODY_MEDIUM,
          backgroundColor: ColorManager.WHITE,
          color: ColorManager.SECONDARY_COLOR,
          fontWeight: FontWeight.w500,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/text_compare.png',
              color: widget.currentIndex == 0
                  ? ColorManager.BLACK
                  : ColorManager.SECONDARY_COLOR,
              width: 24.0,
              height: 24.0,
            ),
            label: TextManager.HOME_NAV_BAR_LABEL,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: TextManager.ABOUT_NAV_BAR_LABEL,
          ),
        ],
        onTap: (value) {
          if (value != widget.currentIndex) {
            if (value == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (route) => false,
              );
            } else if (value == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AboutScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomeScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                (route) => false,
              );
            }
          }
        },
      ),
    );
  }
}
