import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final TextHierarchy textHierarchy;
  final FontWeight fontWeight;
  final bool isPrimaryButton;
  final bool isCropButton;
  final bool isCompare;
  final double width;
  final double height;
  final void Function()? onPressed;
  final double borderRadius;
  final bool needElevation;

  const MyButton({
    super.key,
    required this.isPrimaryButton,
    required this.isCropButton,
    required this.isCompare,
    required this.needElevation,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.text,
    required this.color,
    required this.textHierarchy,
    required this.fontWeight,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: UnitManager.BUTTON_HORIZONTAL_PADDING,
            vertical: UnitManager.BUTTON_VERTICAL_PADDING,
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          isPrimaryButton || isCropButton
              ? ColorManager.SECONDARY_COLOR
              : isCompare
                  ? ColorManager.WHITE
                  : ColorManager.PRIMARY_COLOR,
        ),
        side: isCropButton
            ? const WidgetStatePropertyAll(
                BorderSide(
                  color: ColorManager.WHITE,
                  width: UnitManager.BORDER_WIDTH,
                ),
              )
            : null,
        fixedSize: WidgetStatePropertyAll(
          Size(width, height),
        ),
        elevation: needElevation ? const WidgetStatePropertyAll(4) : null,
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isPrimaryButton
              ? const Icon(
                  Icons.photo_camera,
                  size: UnitManager.PRIMARY_BUTTON_ICON_SIZE,
                  color: ColorManager.WHITE,
                )
              : const SizedBox(),
          MyText(
            text: text,
            color: color,
            textHierarchy: textHierarchy,
            fontWeight: fontWeight,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
