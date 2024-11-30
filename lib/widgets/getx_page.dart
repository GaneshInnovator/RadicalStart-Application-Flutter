import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator_getx.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the logic file

class GetxPage extends StatelessWidget {
  final CalculatorLogic _calculator = Get.put(CalculatorLogic());

  void _onButtonPress(String value) {
    if (RegExp(r'[0-9.]').hasMatch(value) || (value == '+' || value == '-' || value == '÷' || value == '×')) {
      // Input numbers
      _calculator.inputNumber(value);
    } else if (value == 'C') {
      // Clear the calculator
      _calculator.clear();
    } else if (value == '⌫') {
      // Backspace functionality
      if (_calculator.displayValue.isNotEmpty) {
        _calculator.displayValue.value = _calculator.displayValue.value.substring(0, _calculator.displayValue.value.length - 1);
        if (_calculator.displayValue.value.isEmpty) {
          _calculator.displayValue.value = '0';
        }
      }
    } else if (value == '=') {
      // Calculate and display the final result
      _calculator.calculateResult();
    } else {
      // Handle operator input but do not show in TextField
      _calculator.inputOperator(value);
    }
  }

  Widget _buildButton(String text, Color textColor, Color buttonColor, double fontSize) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        elevation: 0,
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      onPressed: () {
        _onButtonPress(text);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Responsive font size
    double fontSize = screenWidth < 350 ? 20 : 24;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Company logo section
            Container(
              height: screenHeight * 0.2, // Adjust based on screen height
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: CachedNetworkImage(
                        imageUrl: 'https://i.imghippo.com/files/HF5879OEk.png',
                        height: 50,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main content with buttons
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Button grid
                    SizedBox(
                      height: screenHeight * 0.55, // Adjust height of the grid
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.0,
                        children: [
                          _buildButton("C", Colors.black, Color(0xFFF1F1F1), fontSize),
                          _buildButton("%", Colors.black, Color(0xFFF1F1F1), fontSize),
                          _buildButton("⌫", Colors.black, Color(0xFFF1F1F1), fontSize),
                          _buildButton("÷", Colors.white, Colors.orange, fontSize),
                          _buildButton("7", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("8", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("9", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("×", Colors.white, Colors.orange, fontSize),
                          _buildButton("4", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("5", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("6", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("-", Colors.white, Colors.orange, fontSize),
                          _buildButton("1", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("2", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("3", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("+", Colors.white, Colors.orange, fontSize),
                          _buildButton(".", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("0", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("00", Colors.black, Color(0xFFF0F5FE), fontSize),
                          _buildButton("=", Colors.black, Color(0xFF1B2FEE), fontSize),
                        ],
                      ),
                    ),

                    // TextField for result display
                    SizedBox(height: 10),
                    Container(
                      child: Obx(() {
                        return TextField(
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF1F1F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                          ),
                          controller: TextEditingController(
                            text: _calculator.displayValue.value, // Reactive display
                          ),
                          readOnly: true,
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.1),
                        );
                      }),
                    ),
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