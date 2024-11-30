import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';

class ProviderPage extends StatelessWidget {
  Widget _buildButton(BuildContext context, String text, Color textColor, Color buttonColor) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(16),
        elevation: 0,
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      onPressed: () {
        if (text == "C") {
          provider.clear();
        } else if (text == "⌫") {
          provider.backspace();
        } else if (text == "=") {
          provider.calculateResult();
        } else {
          provider.inputNumber(text);
        }
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
                          _buildButton(context, "C", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "%", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "⌫", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "÷", Colors.black, Colors.orange),
                          _buildButton(context, "7", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "8", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "9", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "×", Colors.black, Colors.orange),
                          _buildButton(context, "4", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "5", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "6", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "-", Colors.black, Colors.orange),
                          _buildButton(context, "1", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "2", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "3", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "+", Colors.black, Colors.orange),
                          _buildButton(context, ".", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "0", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "00", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "=", Colors.black, Color(0xFF1B2FEE)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Using Consumer to rebuild the TextField with updated text
                    Consumer<CalculatorProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          maxLines: 3,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF1F1F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              //borderSide: BorderSide(color: const Color(0xFFF1F1F1)),
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: provider.displayValue,
                          ),
                          style: TextStyle(fontSize: 25),
                        );
                      },
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