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
      String expression = _displayValue.split('\n')[0];
      dynamic result = _evaluateExpression(expression);

      if (result is double && result == result.toInt()) {
        _displayValue = "${result.toInt()}\n$expression";
      } else {
        _displayValue = "$result\n$expression";
      }
    } catch (e) {
      _displayValue = "Error";
    }
    notifyListeners();
  }

  dynamic _evaluateExpression(String expression) {
    expression = expression.replaceAll("×", "*").replaceAll("÷", "/");

    try {
      List<String> tokens = _tokenizeExpression(expression);
      return _parseExpression(tokens);
    } catch (e) {
      throw FormatException("Invalid expression");
    }
  }

  dynamic _parseExpression(List<String> tokens) {
    tokens = _processMultiplicationDivision(tokens);
    tokens = _processAdditionSubtraction(tokens);

    double result = double.parse(tokens[0]);

    if (result == result.toInt()) {
      return result.toInt();
    }
    return result;
  }

  List<String> _tokenizeExpression(String expression) {
    final regex = RegExp(r'(\d+(\.\d*)?|\+|\-|\×|\÷|\*|\/|%)');
    return regex.allMatches(expression).map((match) => match.group(0)!).toList();
  }

  List<String> _processMultiplicationDivision(List<String> tokens) {
    int i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '*' || tokens[i] == '/' || tokens[i] == '×' || tokens[i] == '÷' || tokens[i] == '%') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double result;

        if (tokens[i] == '*' || tokens[i] == '×') {
          result = left * right;
        } else if (tokens[i] == '/' || tokens[i] == '÷') {
          if (right == 0) {
            throw FormatException("Division by zero");
          }
          result = left / right;
        } else if (tokens[i] == '%') {
          if (right == 0) {
            throw FormatException("Division by zero in modulus");
          }
          result = left % right;
        } else {
          throw FormatException("Invalid operator");
        }

        tokens[i - 1] = result.toString();
        tokens.removeAt(i);
        tokens.removeAt(i);
        i--;
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

        if (tokens[i] == '+') {
          result = left + right;
        } else if (tokens[i] == '-') {
          result = left - right;
        } else {
          throw FormatException("Invalid operator");
        }

        tokens[i - 1] = result.toString();
        tokens.removeAt(i);
        tokens.removeAt(i);
        i--;
      }
      i++;
    }
    return tokens;
  }
}
