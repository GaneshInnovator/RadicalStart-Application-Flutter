import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePreviewPage extends StatefulWidget {
  final XFile image;

  ImagePreviewPage({required this.image});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  late ValueNotifier<XFile> _imageNotifier;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imageNotifier = ValueNotifier<XFile>(XFile(widget.image.path));
  }

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

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _imageNotifier.value = pickedFile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    Color iconcolor = Color(0xFF1B2FEE);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<XFile>(
              valueListenable: _imageNotifier,
              builder: (context, image, child) {
                return Image.file(
                  File(image.path),
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.6,
                  fit: BoxFit.cover,
                );
              },
            ),
            SizedBox(height: screenHeight * 0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: iconcolor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, size: screenWidth * 0.08, color: Colors.white),
                    onPressed: _showImagePickerOptions,
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),

                IconButton(
                  icon: Icon(Icons.check_circle, size: screenWidth * 0.15, color: iconcolor),
                  onPressed: () {
                    Navigator.pop(context, _imageNotifier.value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
