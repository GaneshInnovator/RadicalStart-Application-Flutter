import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'image_preview_page.dart';  // Import ImagePreviewPage

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Show image picker options (Gallery or Camera)
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
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Pick the image from the specified source (Gallery/Camera)
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });

      // Navigate to the ImagePreviewPage with the selected image
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewPage(
            image: pickedFile, // Pass the picked image to the next page
          ),
        ),
      ).then((updatedImage) {
        // Check if an updated image was returned after confirmation
        if (updatedImage != null) {
          setState(() {
            _image = updatedImage;  // Update the image with the confirmed one
          });
        } else {
          // If no image was updated, clear the existing image
          setState(() {
            _image = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color(0xFFF8F7FD), // Apply custom background color
        child: Column(
          children: [
            // Top Section with Logo and Title
            Container(
              width: screenWidth,
              height: screenHeight * 0.25, // Fixed height for top section
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    'https://i.imghippo.com/files/HF5879OEk.png',
                    height: screenHeight * 0.8,
                    width: screenWidth * 0.6,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            // Bottom Section with Blue Box
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
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Upload Container with Image and Edit/Confirm icons
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
                      SizedBox(height: screenHeight * 0.05), // Add spacing
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