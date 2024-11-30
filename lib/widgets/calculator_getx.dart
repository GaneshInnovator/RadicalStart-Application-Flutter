import 'package:get/get.dart';

class CalculatorLogic extends GetxController {
  var displayValue = '0'.obs;
  String _expression = '';
  var finalResult = '';

  void inputNumber(String value) {
    if (displayValue.value == '0') {
      displayValue.value = value;
    } else {
      displayValue.value += value;
    }
    _expression = displayValue.value;
  }

  void inputOperator(String value) {
    if (_expression.isNotEmpty && RegExp(r'[+\-*/]$').hasMatch(_expression)) {
      _expression = _expression.substring(0, _expression.length - 1);
    }
    _expression += value;
    displayValue.value = _expression;
  }

  void clear() {
    displayValue.value = '0';
    _expression = '';
  }

  void calculateResult() {
    try {
      List<String> tokens = _tokenize(_expression);
      finalResult = _evaluate(tokens).toString();
      displayValue.value = "$finalResult\n$_expression";
    } catch (e) {
      displayValue.value = 'Error';
    }
  }

  List<String> _tokenize(String expression) {
    List<String> tokens = [];
    String currentToken = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if (RegExp(r'[0-9.]').hasMatch(char)) {
        currentToken += char;
      } else if (RegExp(r'[+\-*/]').hasMatch(char)) {
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = '';
        }
        tokens.add(char);
      }
    }

    if (currentToken.isNotEmpty) {
      tokens.add(currentToken);
    }

    return tokens;
  }

  double _evaluate(List<String> tokens) {

    List<double> values = [];
    List<String> operators = [];

    for (String token in tokens) {
      if (RegExp(r'[0-9.]').hasMatch(token)) {
        values.add(double.parse(token));
      } else if (token == '+' || token == '-' || token == '*' || token == '/') {
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      double num1 = values.removeAt(0);
      double num2 = values.removeAt(0);
      String operator = operators.removeAt(0);

      switch (operator) {
        case '+':
          values.insert(0, num1 + num2);
          break;
        case '-':
          values.insert(0, num1 - num2);
          break;
        case '*':
          values.insert(0, num1 * num2);
          break;
        case '/':
          if (num2 != 0) {
            values.insert(0, num1 / num2);
          } else {
            throw FormatException('Cannot divide by zero');
          }
          break;
      }
    }

    return values[0];
  }
}