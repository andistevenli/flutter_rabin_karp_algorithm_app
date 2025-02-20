import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/home_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/home/home_screen.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_button.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late final HomeController _provider;

  @override
  void initState() {
    _provider = Provider.of<HomeController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextManager.PREVIEW_TITLE),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Consumer<HomeController>(
              builder: (context, value, child) {
                if (value.finiteState == FiniteState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (value.finiteState == FiniteState.succeed) {
                  return Image.file(
                    File(_provider.imagePath!),
                    fit: BoxFit.contain,
                  );
                } else if (value.finiteState == FiniteState.failed) {
                } else {
                  return const SizedBox();
                }
                return const SizedBox();
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: getProportionateScreenHeight(85.0),
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 18.0,
              horizontal: 24.0,
            ),
            color: ColorManager.SECONDARY_COLOR,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: getProportionateScreenWidth(42.73),
              children: <Widget>[
                MyButton(
                  isPrimaryButton: false,
                  isCropButton: true,
                  isCompare: false,
                  needElevation: true,
                  width: getProportionateScreenWidth(122.27),
                  height: getProportionateScreenHeight(47.82),
                  borderRadius: UnitManager.RADIUS_MEDIUM,
                  text: TextManager.CROP_BUTTON,
                  color: ColorManager.WHITE,
                  textHierarchy: TextHierarchy.header,
                  fontWeight: FontWeight.w500,
                  onPressed: () => _provider.cropImage(),
                ),
                MyButton(
                  isPrimaryButton: false,
                  isCropButton: false,
                  isCompare: false,
                  needElevation: true,
                  width: getProportionateScreenWidth(122.27),
                  height: getProportionateScreenHeight(47.82),
                  borderRadius: UnitManager.RADIUS_MEDIUM,
                  text: TextManager.CONVERT_BUTTON,
                  color: ColorManager.BLACK,
                  textHierarchy: TextHierarchy.header,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    _provider.getConvertResult();
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
