import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/controller/home_controller.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/camera_related_button_type.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/size_config.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/camera/widgets/camera_related_button.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/preview/preview_screen.dart';
import 'package:flutter_rabin_karp_algorithm_app/view/widgets/states/loading_state.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final HomeController _provider;
  bool _isFlashOn = false;
  //this is the instance of Camera Controller from camera package
  CameraController? _cameraController;
  //this variable is used to store the list of camera description properties
  List _cameras = [];
  //this variables is used to define the index of the _cameras list
  int _selectedCameraIndex = 0;

  ///this function aims to initialize the camera package
  ///
  ///at first, this will check the camera controller is still exist in memory or not.
  ///if it's still inside, this will disposing them.
  ///
  ///after that, this will intiliaze the new instance of Camera Controller and add the listener
  ///
  ///this function also check whether the value of camera controller variable is error or not
  ///
  ///created on January 19th, 2025
  _initCamera({required CameraDescription cameraDescription}) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.max);
    _cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (_cameraController!.value.hasError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Camera Error'),
        ));
      }
    }

    try {
      await _cameraController!.initialize();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Camera Error'),
        ));
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _provider = Provider.of<HomeController>(context, listen: false);
    availableCameras().then(
      (value) {
        _cameras = value;
        if (_cameras.isNotEmpty) {
          _selectedCameraIndex = 0;
          _initCamera(cameraDescription: _cameras[_selectedCameraIndex])
              .then((_) {});
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text('Tidak ada kamera'),
            ));
          }
        }
      },
    ).catchError((e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(e.toString()),
        ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: buildCameraPreview(),
            ),
            CameraRelatedButton(
              cameraRelatedButtonType: CameraRelatedButtonType.close,
              isFlashOn: _isFlashOn,
              alignment: Alignment.topLeft,
              onTap: () {
                _isFlashOn = !_isFlashOn;
                _cameraController!.setFlashMode(FlashMode.off);
                Navigator.pop(context);
              },
            ),
            CameraRelatedButton(
              cameraRelatedButtonType: CameraRelatedButtonType.capture,
              isFlashOn: _isFlashOn,
              alignment: Alignment.bottomCenter,
              onTap: () async {
                try {
                  final XFile imageFile =
                      await _cameraController!.takePicture();
                  !_isFlashOn;
                  _cameraController!.setFlashMode(FlashMode.off);
                  _provider.setImageFile(File(imageFile.path));
                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreviewScreen(),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        content: Text(e.toString()),
                      ),
                    );
                  }
                }
              },
            ),
            CameraRelatedButton(
              cameraRelatedButtonType: CameraRelatedButtonType.flash,
              isFlashOn: _isFlashOn,
              alignment: Alignment.bottomLeft,
              onTap: () {
                setState(() {
                  _isFlashOn = !_isFlashOn;
                  _cameraController!.setFlashMode(
                      _isFlashOn ? FlashMode.torch : FlashMode.off);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCameraPreview() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const LoadingState();
    }
    var camera = _cameraController!.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;
    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(
          _cameraController!,
        ),
      ),
    );
  }
}
