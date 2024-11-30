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
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, index, _) => _pages[index],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F7FD),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(top: 18),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: _selectedIndex,
                  builder: (context, index, _) {
                    return BottomNavigationBar(
                      currentIndex: index,
                      onTap: (int newIndex) {
                        _selectedIndex.value = newIndex;
                      },
                      backgroundColor: Colors.transparent,
                      selectedItemColor: const Color(0xFF8026DF),
                      unselectedItemColor: Colors.grey,
                      type: BottomNavigationBarType.fixed,
                      iconSize: 30,
                      elevation: 0,
                      items: const [
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
        },
      ),
    );
  }
}
