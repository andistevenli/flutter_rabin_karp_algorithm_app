import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/model/convert_result.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/color_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/resources/text_manager.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class HomeController with ChangeNotifier {
  //this variable is used to store the Finite State enum
  FiniteState _finiteState = FiniteState.init;
  //this variable is used to store the cropped file
  CroppedFile? _croppedFile;
  //this variable is used to store the image file path from This Camera Controller
  String? _imagePath;
  //this variable is used to store the after-cropped image file
  File? _imageFile;
  //this is the instance of Convert Result data object
  ConvertResult? _convertResult;
  //this variable is used to store the connection status
  bool? _isConnectingToInternet;

  //this is the getter of _finiteState
  FiniteState get finiteState => _finiteState;
  //this is the getter of _croppedFile
  CroppedFile? get croppedFile => _croppedFile;
  //this is the getter of _imagePath
  String? get imagePath => _imagePath;
  //this is the getter of _imageFile
  File? get imageFile => _imageFile;
  //this is the getter -f _convertResult
  ConvertResult? get convertResult => _convertResult;
  //this is the getter of _isConnectingToInternet;
  bool? get isConnectingToInternet => _isConnectingToInternet;

  //this is the setter of croppedFile
  set croppedFile(CroppedFile? value) => croppedFile = value;
  //this is the setter of imagePath
  set imagePath(String? value) => imagePath = value;
  //this is the setter of convertResult
  set convertResult(ConvertResult? value) => convertResult = value;
  //this is the setter of isConnectingToInternet
  set isConnectingToInternet(bool? value) => _isConnectingToInternet = value;

  ///this function aims to change the Finite State and triggering the consumer widget
  ///
  ///created on January 18th, 2025
  void changeFiniteState({required FiniteState value}) {
    _finiteState = value;
    notifyListeners();
  }

  ///this function aims to set the image file after the picture is captured
  ///
  ///created on January 21th, 2025
  void setImageFile(File? imageFile) {
    try {
      _imageFile == null;
      changeFiniteState(value: FiniteState.loading);
      _imageFile = imageFile;
      if (_imageFile == null) {
        _imagePath = '';
      } else {
        _imagePath = _imageFile!.path;
      }
      changeFiniteState(value: FiniteState.succeed);
    } catch (e) {
      changeFiniteState(value: FiniteState.failed);
      throw Exception(e);
    }
  }

  ///this function aims to crop the image
  ///
  ///created on January 22nd, 2025
  Future<void> cropImage() async {
    final croppedFile = await setImageCropperPreference();
    if (croppedFile != null) {
      setImageFile(File(croppedFile.path));
    }
  }

  ///this function aims to set the preference/setting of Image Cropper package
  ///
  ///created on January 22nd, 2025
  Future<CroppedFile?> setImageCropperPreference() {
    return ImageCropper().cropImage(
      sourcePath: imagePath!,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: TextManager.CROPPER_TITLE,
          cropFrameColor: ColorManager.WHITE,
          activeControlsWidgetColor: Colors.red,
          toolbarColor: ColorManager.SECONDARY_COLOR,
          toolbarWidgetColor: ColorManager.WHITE,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
      ],
    );
  }

  Future<RecognizedText> convertImageToText() async {
    final InputImage _inputImage = InputImage.fromFilePath(_imagePath!);
    final TextRecognizer _textRecognizer =
        TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText _recognizedText =
        await _textRecognizer.processImage(_inputImage);
    _textRecognizer.close();
    return _recognizedText;
  }

  Future<void> getConvertResult() async {
    try {
      changeFiniteState(value: FiniteState.loading);
      final RecognizedText _recognizedText = await convertImageToText();
      _convertResult = ConvertResult(text: _recognizedText.text);
      changeFiniteState(value: FiniteState.succeed);
    } catch (e) {
      changeFiniteState(value: FiniteState.failed);
      throw Exception(e);
    }
  }
}
