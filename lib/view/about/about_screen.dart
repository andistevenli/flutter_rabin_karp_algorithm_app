import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/spacer.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(UnitManager.SCREEN_PADDING),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo/text_me_up_logo.png',
                  width: 164.0,
                  height: 154.0,
                ),
                const MyText(
                  text: TextManager.VERSION,
                  color: ColorManager.BLACK,
                  textHierarchy: TextHierarchy.bodyLarge,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
                Divider(
                  thickness: 1.0,
                  color: ColorManager.SECONDARY_COLOR,
                ),
                const MyText(
                  text: TextManager.DESCRIPTION,
                  color: ColorManager.BLACK,
                  textHierarchy: TextHierarchy.bodyLarge,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const MyText(
                      text: TextManager.MADE_BY_LABEL,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyLarge,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    const MyText(
                      text: TextManager.MADE_BY_NAME,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyLarge,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    const MyText(
                      text: TextManager.MADE_BY_NIM,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyLarge,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Image.asset('assets/images/university_logo.png'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const MyText(
                      text: TextManager.MAJOR_NAME,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyLarge,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    const MyText(
                      text: TextManager.UNIVERSITY_NAME,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.display,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
