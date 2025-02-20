import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/unit_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/camera_related_button_type.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';

class CameraRelatedButton extends StatelessWidget {
  final AlignmentGeometry alignment;
  final bool isFlashOn;
  final VoidCallback onTap;
  final CameraRelatedButtonType cameraRelatedButtonType;

  const CameraRelatedButton({
    super.key,
    required this.cameraRelatedButtonType,
    required this.isFlashOn,
    required this.alignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: _buildButtonType(),
    );
  }

  Widget _buildButtonType() {
    if (cameraRelatedButtonType == CameraRelatedButtonType.capture) {
      return Container(
        color: Colors.transparent,
        width: getProportionateScreenWidth(UnitManager.CAPTURE_BUTTON_SIZE),
        height: getProportionateScreenHeight(UnitManager.CAPTURE_BUTTON_SIZE),
        child: IconButton(
          onPressed: onTap,
          icon: Image.asset(
            'assets/images/take_a_picture.png',
            width: getProportionateScreenWidth(UnitManager.CAPTURE_BUTTON_SIZE),
            height:
                getProportionateScreenHeight(UnitManager.CAPTURE_BUTTON_SIZE),
          ),
        ),
      );
    } else if (cameraRelatedButtonType == CameraRelatedButtonType.flash) {
      return Container(
        color: Colors.transparent,
        width: SizeConfig.screenWidth / 3,
        height: 80.0,
        child: IconButton(
          onPressed: onTap,
          splashRadius: 74.85,
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
            size: 40.0,
            color: ColorManager.WHITE,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 80.0,
        height: 80.0,
        child: IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.close_rounded,
            color: ColorManager.WHITE,
            size: 40.0,
          ),
        ),
      );
    }
  }
}
