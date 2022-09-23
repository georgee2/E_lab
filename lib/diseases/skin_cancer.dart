import 'dart:io';

import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_utils_class/image_utils_class.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class SkinCancer extends StatefulWidget {
  const SkinCancer({Key key}) : super(key: key);

  @override
  State<SkinCancer> createState() => _SkinCancerState();
}

class _SkinCancerState extends State<SkinCancer> {
  ImagePicker picker = ImagePicker();
  XFile imageCamera;
  XFile imageGallery;
  bool mainWidget;
  FToast fToast;
  File imagePicked;
  File skinModel;
  Interpreter interpreter;
  var imageBytes;

  //var output;
  List result;

  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;
  FirebaseModelDownloadConditions conditions = FirebaseModelDownloadConditions(
    iosAllowsCellularAccess: true,
    iosAllowsBackgroundDownloading: false,
    androidChargingRequired: false,
    androidWifiRequired: false,
    androidDeviceIdleRequired: false,
  );

  getLastModel() async {
    try {
      FirebaseCustomModel model = await downloader.getModel(
          'SkinCancer', FirebaseModelDownloadType.localModel, conditions);
      assert(model != null);
      setState(() {
        skinModel = model.file;
      });
      return model;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('The program will not be resumed');
      }
      rethrow;
    }
  }

  loadSkinModel() async {
    await Tflite.loadModel(
        model: "assets/skin_TFLite.tflite",
        //labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
        );
  }
//nv/df/bkl/bcc/akiec/vasc/mel
  runSkinModel() async {
    var output = await Tflite.runModelOnImage(
      path: imagePicked.path, // required
      imageMean: 127.5, // defaults to 117.0
      imageStd: 127.5, // defaults to 1.0
      numResults: 7, // defaults to 5
      threshold: 0.1, // defaults to 0.1
      asynch: true, // defaults to true
    );
    setState(() {
      result = output;
    });
    if (kDebugMode) {
      print('result is:    ' + result[0]['label']);
    }
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageProcess(File image) {
    var base64 = ImageUtils.fileToBase64(image);
    return ImageUtils.base64ToUnit8list(base64);
  }

  // Uint8List imageToByteListUint8(img.Image image, int inputSize) {
  //   var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
  //   var buffer = Uint8List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = img.getRed(pixel);
  //       buffer[pixelIndex++] = img.getGreen(pixel);
  //       buffer[pixelIndex++] = img.getBlue(pixel);
  //     }
  //   }
  //   return convertedBytes.buffer.asUint8List();
  // }

  // Float32List imageToByteListFloat32(
  //     img.Image image, int inputSize) {
  //   var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
  //   var buffer = Float32List.view(convertedBytes.buffer);
  //   int pixelIndex = 0;
  //   for (var i = 0; i < inputSize; i++) {
  //     for (var j = 0; j < inputSize; j++) {
  //       var pixel = image.getPixel(j, i);
  //       buffer[pixelIndex++] = img.getRed(pixel) / 255.0;
  //       buffer[pixelIndex++] = img.getGreen(pixel) / 255.0;
  //       buffer[pixelIndex++] = img.getBlue(pixel) / 255.0;
  //     }
  //   }
  //   return convertedBytes.buffer.asFloat32List();
  // }

  classifyImage() async {
    var imageBytes = (await rootBundle.load('assets/nv.jpeg')).buffer;
    img.Image oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage, height: 28, width: 28);
    var output = await Tflite.runModelOnBinary(
        binary: imageToByteListFloat32(resizedImage, 28, 28, 28),// required
        numResults: 7,    // defaults to 5
        threshold: 0.05,  // defaults to 0.1
        asynch: true      // defaults to true
    );
    setState(() {
      result = output;
    });
    if (kDebugMode) {
      print(result);
    }
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    //getLastModel();
    loadSkinModel();
  }

  getImageFromCamera() async {
    imageCamera = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imagePicked = File(imageCamera.path);
    });
    imageBytes = img.decodeImage(await imagePicked.readAsBytes());
    // interpreter = Interpreter.fromFile(skinModel);
    // interpreter.run(imagePicked, output);
    // print(output);
  }

  getImageFromGallery() async {
    imageGallery = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePicked = File(imageGallery.path);
    });
    imageBytes = img.decodeImage(await imagePicked.readAsBytes());
  }

  showImagesDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Choose image from:',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  getImageFromGallery();
                  Navigator.pop(context);
                },
                child: const Text('Pick from gallery'),
              ),
              TextButton(
                onPressed: () => getImageFromCamera(),
                child: const Text('Pick from camera'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainWidget = (imageCamera == null && imageGallery == null) ? true : false;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("2F409C"),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                'Skin Cancer',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 10.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    mainWidget
                        ? const SizedBox()
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                image: FileImage(imagePicked),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    mainWidget
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: HexColor('2F409C'),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () => getImageFromCamera(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Upload from camera',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                  color: HexColor('2F409C'),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: () => getImageFromGallery(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.image,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Upload from gallery',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : TextButton(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: HexColor('2F409C'),
                              ),
                              child: const Text(
                                '+ retake another photo',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () => showImagesDialog(),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    mainWidget
                        ? const SizedBox()
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: HexColor('2F409C'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (imagePicked.path == null) {
                                  fToast.showToast(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.blue.shade900,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.check),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                            Text(
                                                "Make sure your choices are valid"),
                                          ],
                                        ),
                                      ),
                                      gravity: ToastGravity.BOTTOM,
                                      toastDuration: const Duration(seconds: 2),
                                      positionedToastBuilder: (context, child) {
                                        return Positioned(
                                          child: child,
                                          top: 16.0,
                                          left: 16.0,
                                        );
                                      });
                                } else {
                                  classifyImage();
                                  //runSkinModel();
                                  fToast.showToast(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 12.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          color: Colors.greenAccent,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.check),
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                            Text("Wait for your result"),
                                          ],
                                        ),
                                      ),
                                      gravity: ToastGravity.BOTTOM,
                                      toastDuration: const Duration(seconds: 2),
                                      positionedToastBuilder: (context, child) {
                                        return Positioned(
                                          child: child,
                                          top: 16.0,
                                          left: 16.0,
                                        );
                                      });
                                }
                              },
                              child: const Text(
                                'Start',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    mainWidget ? const Text('') : const Text(''),
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
