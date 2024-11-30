import 'package:flutter/material.dart';

class CalculatorProvider with ChangeNotifier {
  String _displayValue = "0";

  String get displayValue => _displayValue;

  void inputNumber(String value) {
    if (_displayValue == "0" && value != ".") {
      _displayValue = value;
    } else {
      _displayValue += value;
    }
    notifyListeners();
  }

  void clear() {
    _displayValue = "0";
    notifyListeners();
  }

  void backspace() {
    if (_displayValue.length > 1) {
      _displayValue = _displayValue.substring(0, _displayValue.length - 1);
    } else {
      _displayValue = "0";
    }
    notifyListeners();
  }

  void calculateResult() {
    try {
      String expression = _displayValue.split('\n')[0]; // Get only the first line
      double result = _evaluateExpression(expression);
      _displayValue = "$expression\n$result"; // Display equation and result in separate lines
    } catch (e) {
      _displayValue = "Error";
    }
    notifyListeners();
  }

  double _evaluateExpression(String expression) {
    // Replace mathematical symbols for calculation
    expression = expression.replaceAll("×", "*").replaceAll("÷", "/");

    try {
      // Split the expression into numbers and operators
      List<String> tokens = _tokenizeExpression(expression);

      // Perform calculation with proper order of operations (multiplication and division first)
      return _parseExpression(tokens);
    } catch (e) {
      throw FormatException("Invalid expression");
    }
  }

  double _parseExpression(List<String> tokens) {
    // Handle multiplication/division
    tokens = _processMultiplicationDivision(tokens);

    // Handle addition/subtraction
    tokens = _processAdditionSubtraction(tokens);

    // The remaining token should be the result
    return double.parse(tokens[0]);
  }

  List<String> _tokenizeExpression(String expression) {
    final regex = RegExp(r'(\d+(\.\d*)?|\+|\-|\×|\÷|\*|\/|👦|👦)');
    return regex.allMatches(expression).map((match) => match.group(0)!).toList();
  }

  List<String> _processMultiplicationDivision(List<String> tokens) {
    int i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '*' || tokens[i] == '/' || tokens[i] == '×' || tokens[i] == '÷') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double result;

        // Apply multiplication or division
        if (tokens[i] == '*' || tokens[i] == '×') {
          result = left * right;
        } else if (tokens[i] == '/' || tokens[i] == '÷') {
          if (right == 0) {
            throw FormatException("Division by zero");
          }
          result = left / right;
        } else {
          throw FormatException("Invalid operator");
        }

        // Replace the operator and operands with the result
        tokens[i - 1] = result.toString();
        tokens.removeAt(i);
        tokens.removeAt(i); // Remove the next operand
        i--; // Step back to re-check the previous token in the next iteration
      }
      i++;
    }
    return tokens;
  }

  List<String> _processAdditionSubtraction(List<String> tokens) {
    int i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '+' || tokens[i] == '-') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double result;

        // Apply addition or subtraction
        if (tokens[i] == '+') {
          result = left + right;
        } else if (tokens[i] == '-') {
          result = left - right;
        } else {
          throw FormatException("Invalid operator");
        }

        // Replace the operator and operands with the result
        tokens[i - 1] = result.toString();
        tokens.removeAt(i);
        tokens.removeAt(i); // Remove the next operand
        i--; // Step back to re-check the previous token in the next iteration
      }
      i++;
    }
    return tokens;
  }
}