import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator_getx.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/colors.dart';

class GetxPage extends StatelessWidget {
  final CalculatorLogic _calculator = Get.put(CalculatorLogic());

  void _onButtonPress(String value) {
    if (RegExp(r'[0-9.]').hasMatch(value) || (value == '+' || value == '-' || value == '÷' || value == '×')) {
      _calculator.inputNumber(value);
    } else if (value == 'C') {

      _calculator.clear();
    } else if (value == '⌫') {

      if (_calculator.displayValue.isNotEmpty) {
        _calculator.displayValue.value = _calculator.displayValue.value.substring(0, _calculator.displayValue.value.length - 1);
        if (_calculator.displayValue.value.isEmpty) {
          _calculator.displayValue.value = '0';
        }
      }
    } else if (value == '=') {
      _calculator.calculateResult();
    } else {

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
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth < 350 ? 20 : 24;
    double textSize = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.2,
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
                    SizedBox(
                      height: screenHeight * 0.55,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.0,
                        children: [
                          _buildButton("C", Colors.black, Color(0xFFF1F1F1), textSize),
                          _buildButton("%", Colors.black, Color(0xFFF1F1F1), textSize),
                          _buildButton("⌫", Colors.black, Color(0xFFF1F1F1), textSize),
                          _buildButton("÷", Colors.white, Colors.orange, textSize),
                          _buildButton("7", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("8", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("9", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("×", Colors.white, Colors.orange, textSize),
                          _buildButton("4", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("5", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("6", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("-", Colors.white, Colors.orange, textSize),
                          _buildButton("1", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("2", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("3", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("+", Colors.white, Colors.orange, textSize),
                          _buildButton(".", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("0", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("00", Colors.black, Color(0xFFF0F5FE), textSize),
                          _buildButton("=", Colors.white, Color(0xFF1B2FEE), textSize),
                        ],
                      ),
                    ),

                    SizedBox(height: 50),
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
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 16,
                            ),
                          ),
                          controller: TextEditingController(
                            text: _calculator.displayValue.value,
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