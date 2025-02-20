import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/home_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/rabin_karp_algorithm.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/spacer.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/text_hierarchy.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/camera/camera_screen.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_button.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text_box.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _provider;
  final TextEditingController _testerController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _testerNode = FocusNode();
  double _result = 0;

  @override
  void initState() {
    _provider = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            38.0.vSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16.0,
              children: <Widget>[
                Image.asset(
                  'assets/logo/text_me_up_logo.png',
                  width: getProportionateScreenWidth(89.0),
                  height: getProportionateScreenHeight(84.0),
                ),
                const MyText(
                  text: TextManager.HOME_TITLE,
                  color: ColorManager.BLACK,
                  textHierarchy: TextHierarchy.bodyLarge,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            18.0.vSpace,
            const Divider(
              color: ColorManager.SECONDARY_COLOR,
              height: UnitManager.LINE_HEIGHT,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(UnitManager.SCREEN_PADDING),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const MyText(
                      text: TextManager.HOME_CAPTION,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodySmall,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    40.0.vSpace,
                    MyButton(
                      isPrimaryButton: true,
                      isCropButton: false,
                      isCompare: false,
                      needElevation: true,
                      width: getProportionateScreenWidth(317.0),
                      height: getProportionateScreenHeight(72.0),
                      borderRadius: UnitManager.RADIUS_MEDIUM,
                      text: TextManager.HOME_TAKE_PICTURE_BUTTON,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodySmall,
                      fontWeight: FontWeight.w500,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CameraScreen(),
                        ),
                      ),
                    ),
                    23.0.vSpace,
                    Consumer<HomeController>(
                      builder: (context, value, child) {
                        if (value.finiteState == FiniteState.loading) {
                        } else if (value.finiteState == FiniteState.succeed) {
                          return MyTextBox(
                            title: TextManager.CONVERT_TEXT_BOX_TITLE,
                            text: value.convertResult == null
                                ? TextManager.CONVERT_TEXT_BOX_HINT
                                : value.convertResult!.text!,
                            color: ColorManager.BLACK,
                          );
                        } else if (value.finiteState == FiniteState.failed) {
                        } else {
                          return const MyTextBox(
                            title: TextManager.CONVERT_TEXT_BOX_TITLE,
                            text: TextManager.CONVERT_TEXT_BOX_HINT,
                            color: ColorManager.SECONDARY_COLOR,
                          );
                        }
                        return const MyTextBox(
                          title: TextManager.CONVERT_TEXT_BOX_TITLE,
                          text: TextManager.CONVERT_TEXT_BOX_HINT,
                          color: ColorManager.SECONDARY_COLOR,
                        );
                      },
                    ),
                    21.0.vSpace,
                    Form(
                      key: _formKey,
                      child: MyTextField(
                        title: TextManager.TESTER_TEXT_BOX_TITLE,
                        hint: TextManager.TESTER_TEXT_BOX_HINT,
                        controller: _testerController,
                        currentFocus: _testerNode,
                      ),
                    ),
                    21.0.vSpace,
                    const MyText(
                      text: TextManager.HOME_EXPLANATION,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyMedium,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    24.0.vSpace,
                    MyButton(
                      isPrimaryButton: false,
                      isCropButton: false,
                      isCompare: true,
                      needElevation: true,
                      width: getProportionateScreenWidth(99.0),
                      height: double.infinity,
                      borderRadius: UnitManager.RADIUS_SMALL,
                      text: TextManager.HOME_COMPARE_BUTTON,
                      color: ColorManager.BLACK,
                      textHierarchy: TextHierarchy.bodyMedium,
                      fontWeight: FontWeight.w500,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_provider.convertResult == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                content: MyText(
                                    text: 'Hasil konversi masih kosong',
                                    color: ColorManager.WHITE,
                                    textHierarchy: TextHierarchy.bodyLarge,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.start),
                              ),
                            );
                          } else {
                            _result = RabinKarpAlgorithm.rabinKarpSimilarity(
                              conversionText: _provider.convertResult!.text!,
                              testerText: _testerController.text,
                            );
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding: const EdgeInsets.all(17.0),
                                  decoration: const BoxDecoration(
                                    color: ColorManager.SECONDARY_COLOR,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          UnitManager.RADIUS_LARGE),
                                      topRight: Radius.circular(
                                          UnitManager.RADIUS_LARGE),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/text_me_up_bottom_sheet.png',
                                          width: 41.0,
                                          height: 38.0,
                                        ),
                                        13.0.vSpace,
                                        const MyText(
                                          text: 'Accuracy of Result',
                                          color: ColorManager.BLACK,
                                          textHierarchy: TextHierarchy.display,
                                          fontWeight: FontWeight.bold,
                                          textAlign: TextAlign.center,
                                        ),
                                        13.0.vSpace,
                                        MyText(
                                          text:
                                              '${_result.toStringAsFixed(2)}%',
                                          color: ColorManager.BLACK,
                                          textHierarchy: TextHierarchy.header,
                                          fontWeight: FontWeight.normal,
                                          textAlign: TextAlign.center,
                                        ),
                                        29.0.vSpace,
                                        MyButton(
                                          isPrimaryButton: false,
                                          isCropButton: false,
                                          isCompare: false,
                                          needElevation: false,
                                          width: getProportionateScreenWidth(
                                              88.74),
                                          height: 50,
                                          borderRadius:
                                              UnitManager.RADIUS_EXTRA_SMALL,
                                          text: 'Ok',
                                          color: ColorManager.BLACK,
                                          textHierarchy:
                                              TextHierarchy.bodyLarge,
                                          fontWeight: FontWeight.normal,
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
