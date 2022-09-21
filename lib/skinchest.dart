import 'dart:io';

import 'package:e_lab/api/receive_data.dart';
import 'package:e_lab/api/send_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class SkinChest extends StatefulWidget {
  final String title;

  const SkinChest({Key key, this.title}) : super(key: key);

  @override
  State<SkinChest> createState() => _SkinChestState();
}

class _SkinChestState extends State<SkinChest> {

  ImagePicker picker = ImagePicker();
  XFile imageCamera;
  XFile imageGallery;

  bool mainWidget;
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  File imagePicked;
  var imageBytes;

  getImageFromCamera() async {
    imageCamera = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imagePicked = File(imageCamera.path);
      imageBytes = imagePicked.readAsBytesSync();
    });
  }

  getImageFromGallery() async {
    imageGallery = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePicked = File(imageGallery.path);
    });
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
                onPressed: () => getImageFromGallery(),
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
  Widget build(BuildContext context) {
    mainWidget = (imageCamera == null && imageGallery == null) ? true : false;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: HexColor("2F409C"),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 35, color: Colors.white),
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
                      height:
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    mainWidget? Row(
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
                                Icon(Icons.camera_alt_outlined, size: 50, color: Colors.white,),
                                SizedBox(height: 15,),
                                Text('Upload from camera', style: TextStyle(color: Colors.white),),
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
                                Icon(Icons.image, size: 50, color: Colors.white,),
                                SizedBox(height: 15,),
                                Text('Upload from camera', style: TextStyle(color: Colors.white),),
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
                    mainWidget? const SizedBox() : Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: HexColor('2F409C'),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if(imagePicked.path == null) {
                            fToast.showToast(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.blue.shade900,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.check),
                                      SizedBox(
                                        width: 12.0,
                                      ),
                                      Text("Make sure your choices are valid"),
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
                                }
                            );
                          }else{
                            print(imagePicked);
                            SendData().dioUploadImage(imagePicked, widget.title);
                            ReceiveData().getData();
                            fToast.showToast(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
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
                                }
                            );
                          }
                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height * 0.05,
                    ),
                    mainWidget? const Text('') : const Text(''),
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
