import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'image_preview_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  int _galleryDeniedCount = 0;
  int _cameraDeniedCount = 0;

  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _handleGalleryAccess();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _handleCameraAccess();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleGalleryAccess() async {
    var status = await Permission.photos.status;

    if (status.isGranted) {
      _pickImage(ImageSource.gallery);
    } else if (status.isDenied) {
      _galleryDeniedCount++;
      if (_galleryDeniedCount >= 3) {
        _showSettingsOption(
            AppStrings.galleryPermanantlyDenied);
      } else {
        _requestGalleryPermission();
      }
    } else if (status.isPermanentlyDenied) {
      _showSettingsOption(
          AppStrings.galleryPermanantlyDenied);
    }
  }

  Future<void> _handleCameraAccess() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      _pickImage(ImageSource.camera);
    } else if (status.isDenied) {
      _cameraDeniedCount++;
      if (_cameraDeniedCount >= 3) {
        _showSettingsOption(
            AppStrings.cameraPermanantlyDenied);
      } else {
        _requestCameraPermission();
      }
    } else if (status.isPermanentlyDenied) {
      _showSettingsOption(
          AppStrings.cameraPermanantlyDenied);
    }
  }

  Future<void> _requestGalleryPermission() async {
    if (await Permission.photos.request().isGranted) {
      _pickImage(ImageSource.gallery);
    } else {
      _showPermissionError(AppStrings.galleryPermissionError);
    }
  }

  Future<void> _requestCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      _pickImage(ImageSource.camera);
    } else {
      _showPermissionError(AppStrings.cameraPermissionError);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
            image: pickedFile,
          ),
        ),
      ).then((updatedImage) {
        if (updatedImage != null) {
          setState(() {
            _image = updatedImage;
          });
        } else {
          setState(() {
            _image = null;
          });
        }
      });
    }
  }

  void _showPermissionError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsOption(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: AppColors.secondaryColor,
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://i.imghippo.com/files/HF5879OEk.png',
                    height: screenHeight * 0.8,
                    width: screenWidth * 0.6,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenWidth * 0.08),
                    topRight: Radius.circular(screenWidth * 0.08),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                        ),
                        child: Text(
                          AppStrings.uploadImageTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            width: screenWidth * 0.9,
                            height: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius:
                              BorderRadius.circular(screenWidth * 0.08),
                            ),
                            child: _image == null
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.2,
                                      height: screenWidth * 0.2,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1B2FEE),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: screenWidth * 0.15,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.04,
                                  ),
                                  child: Image.file(
                                    File(_image?.path ?? ''),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}