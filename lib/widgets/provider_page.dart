import 'package:flutter/material.dart';
import 'calculator_logic.dart'; // Import your logic file here

class ProviderPage extends StatefulWidget {
  @override
  _ProviderPageState createState() => _ProviderPageState();
}

class _ProviderPageState extends State<ProviderPage> {
  final CalculatorLogic _calculator = CalculatorLogic();

  void _onButtonPress(String value) {
    setState(() {
      if (RegExp(r'[0-9.]').hasMatch(value) || (value == '+' || value == '-' || value == '÷' || value == '×')) {
        // Input numbers
        _calculator.inputNumber(value);
      } else if (value == 'C') {
        // Clear the calculator
        _calculator.clear();
      } else if (value == '⌫') {
        // Backspace functionality
        if (_calculator.displayValue.isNotEmpty) {
          _calculator.displayValue = _calculator.displayValue.substring(
              0, _calculator.displayValue.length - 1);
          if (_calculator.displayValue.isEmpty) {
            _calculator.displayValue = '0';
          }
        }
      } else if (value == '=') {
        // Calculate and display the final result
        _calculator.inputOperator(value);
        _calculator.calculateResult();
      } else {
        // Handle operator input but do not show in TextField
        _calculator.inputOperator(value);
      }
    });
  }

  Widget _buildButton(String text, Color textColor, Color buttonColor) {
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
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section for the company logo
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Image.network(
                        'https://i.imghippo.com/files/HF5879OEk.png',
                        height: 50,
                        fit: BoxFit.contain,
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
                    // GridView for buttons
                    SizedBox(
                      height: 500,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.0,
                        children: [
                          _buildButton("C", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton("%", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton("⌫", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton("÷", Colors.black, Colors.orange),
                          _buildButton("7", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("8", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("9", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("×", Colors.black, Colors.orange),
                          _buildButton("4", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("5", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("6", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("-", Colors.black, Colors.orange),
                          _buildButton("1", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("2", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("3", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("+", Colors.black, Colors.orange),
                          _buildButton(".", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("0", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("00", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton("=", Colors.black, Color(0xFF1B2FEE)),
                        ],
                      ),
                    ),

                    // Spacer between button grid and text field
                    SizedBox(height: 10),

                    // Fixed height for the TextField at the bottom
                    Container(
                      child: TextField(
                        maxLines: 3, // Allows the text field to grow
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
                            vertical: 20, // Adjust vertical padding
                            horizontal: 16, // Adjust horizontal padding
                          ),
                        ),
                        controller: TextEditingController(
                          text: _calculator.displayValue, // Link displayValue to TextField
                        ),
                        readOnly: true, // Make it non-editable
                        style: TextStyle(fontSize: 18), // Adjust font size if needed
                      ),
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProviderPage(),
  ));
}