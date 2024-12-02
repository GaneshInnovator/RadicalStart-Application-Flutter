import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calculator_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/colors.dart';

class ProviderPage extends StatelessWidget {
  Widget _buildButton(
      BuildContext context, String text, Color textColor, Color buttonColor) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: CircleBorder(),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
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
          fontSize: MediaQuery.of(context).size.width * 0.08,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Row(
                  children: [
                    Flexible(
                      child: CachedNetworkImage(
                        imageUrl: 'https://i.imghippo.com/files/HF5879OEk.png',
                        height: screenHeight * 0.06,
                        fit: BoxFit.cover,
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
                  topLeft: Radius.circular(screenWidth * 0.1),
                  topRight: Radius.circular(screenWidth * 0.1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.6,
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: screenWidth * 0.03,
                        mainAxisSpacing: screenHeight * 0.02,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 1.0,
                        children: [
                          _buildButton(context, "C", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "%", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "⌫", Colors.black, Color(0xFFF1F1F1)),
                          _buildButton(context, "÷", Colors.white, Colors.orange),
                          _buildButton(context, "7", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "8", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "9", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "×", Colors.white, Colors.orange),
                          _buildButton(context, "4", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "5", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "6", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "-", Colors.white, Colors.orange),
                          _buildButton(context, "1", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "2", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "3", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "+", Colors.white, Colors.orange),
                          _buildButton(context, ".", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "0", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "00", Colors.black, Color(0xFFF0F5FE)),
                          _buildButton(context, "=", Colors.white, Color(0xFF1B2FEE)),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Consumer<CalculatorProvider>(
                      builder: (context, provider, child) {
                        return TextField(
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF1F1F1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.04),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          readOnly: true,
                          controller: TextEditingController(
                            text: provider.displayValue,
                          ),
                          style: TextStyle(
                            fontSize: screenWidth * 0.1,
                          ),
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
