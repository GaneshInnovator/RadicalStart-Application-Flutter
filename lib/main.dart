import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radicalapp1/widgets/getx_page.dart';
import 'package:radicalapp1/widgets/upload_page.dart';
import 'widgets/provider_page.dart';
import 'widgets/calculator_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: MyApp(),
    ),
  );
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
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [
    ProviderPage(),
    GetxPage(),
    UploadPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, _) => _pages[index],
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