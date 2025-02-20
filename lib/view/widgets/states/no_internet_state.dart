import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_button.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';

class NoInternetState extends StatelessWidget {
  final void Function()? onPressed;

  const NoInternetState({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UnitManager.SCREEN_PADDING),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24.0,
          children: <Widget>[
            Image.asset(
              'assets/images/no_internet_connection.png',
            ),
            const MyText(
              text: TextManager.LOST_CONNECTION,
              color: ColorManager.BLACK,
              textHierarchy: TextHierarchy.header,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            MyButton(
              isPrimaryButton: false,
              isCropButton: false,
              isCompare: false,
              needElevation: true,
              width: 150.0,
              height: 50.0,
              borderRadius: UnitManager.RADIUS_SMALL,
              text: 'Coba Lagi',
              color: ColorManager.BLACK,
              textHierarchy: TextHierarchy.bodyMedium,
              fontWeight: FontWeight.w500,
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
