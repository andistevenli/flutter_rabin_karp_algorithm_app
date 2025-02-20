import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String title;
  final Color color;

  const MyTextBox({
    super.key,
    required this.title,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: UnitManager.TEXT_BOX_VERTICAL_PADDING,
        horizontal: UnitManager.TEXT_BOX_HORIZONTAL_PADDING,
      ),
      height: getProportionateScreenHeight(186.0),
      width: getProportionateScreenWidth(317.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UnitManager.RADIUS_EXTRA_LARGE),
        color: ColorManager.WHITE,
        border: Border.all(
          color: ColorManager.BLACK,
          width: UnitManager.BORDER_WIDTH,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: <Widget>[
          MyText(
            text: title,
            color: ColorManager.BLACK,
            textHierarchy: TextHierarchy.display,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.start,
          ),
          const Divider(
            color: ColorManager.BLACK,
            height: UnitManager.LINE_HEIGHT,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: MyText(
                text: text,
                color: color,
                textHierarchy: TextHierarchy.bodySmall,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
