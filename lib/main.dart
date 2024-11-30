import 'package:flutter/material.dart';
import 'widgets/provider_page.dart'; // Import the ProviderPage
import 'widgets/upload_page.dart'; // Import the UploadPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Use ValueNotifier for state management
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  // List of pages
  final List<Widget> _pages = [
    ProviderPage(), // Provider Page
    Center(child: Text('GetX Page')), // Placeholder for GetX Page
    UploadPage(), // Replace placeholder with UploadPage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) {
          return _pages[index]; // Display the selected page
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F7FD), // Bottom navigation background color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), // Rounded top-left corner
            topRight: Radius.circular(30), // Rounded top-right corner
          ),
        ),
        padding: EdgeInsets.only(top: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, index, _) {
              return BottomNavigationBar(
                currentIndex: index,
                onTap: (int newIndex) {
                  _selectedIndex.value = newIndex; // Update selected index
                },
                backgroundColor: Colors.transparent, // Transparent background
                selectedItemColor: Color(0xFF8026DF), // Selected item color
                unselectedItemColor: Colors.grey, // Unselected item color
                type: BottomNavigationBarType.fixed,
                iconSize: 30, // Icon size
                elevation: 0, // No shadow
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Provider',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_tree_outlined),
                    label: 'GetX',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.image_outlined),
                    label: 'Upload',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}