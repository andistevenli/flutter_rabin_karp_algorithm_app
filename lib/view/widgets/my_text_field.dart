import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';

class MyTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final FocusNode currentFocus;

  const MyTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.currentFocus,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
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
            text: widget.title,
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
            child: TextFormField(
              cursorColor: ColorManager.BLACK,
              controller: widget.controller,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                backgroundColor: ColorManager.WHITE,
                color: ColorManager.BLACK,
                fontSize: UnitManager.BODY_SMALL,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 6,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  backgroundColor: ColorManager.WHITE,
                  color: ColorManager.SECONDARY_COLOR,
                  fontSize: UnitManager.BODY_SMALL,
                  fontWeight: FontWeight.w400,
                ),
                errorStyle: const TextStyle(
                  backgroundColor: ColorManager.WHITE,
                  color: Colors.red,
                  fontSize: UnitManager.BODY_SMALL,
                  fontWeight: FontWeight.w400,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.WHITE, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.WHITE, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.WHITE, width: 0.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.WHITE, width: 0.0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.WHITE, width: 0.0),
                ),
              ),
              onTapOutside: (event) {
                widget.currentFocus.unfocus();
              },
              onFieldSubmitted: (value) {
                widget.currentFocus.unfocus();
              },
              onEditingComplete: () {
                widget.currentFocus.unfocus();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Teks penguji wajib diisi';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
