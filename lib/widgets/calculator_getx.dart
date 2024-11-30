import 'package:get/get.dart';

class CalculatorLogic extends GetxController {
  var displayValue = '0'.obs;
  String _expression = '';

  // Input a number
  void inputNumber(String value) {
    if (displayValue.value == '0') {
      displayValue.value = value;
    } else {
      displayValue.value += value;
    }
    _expression = displayValue.value;  // Update the expression
  }

  // Input an operator (+, -, *, /)
  void inputOperator(String value) {
    if (_expression.isNotEmpty && RegExp(r'[+\-*/]$').hasMatch(_expression)) {
      _expression = _expression.substring(0, _expression.length - 1);  // Replace last operator
    }
    _expression += value;
    displayValue.value = _expression; // Update display
  }

  // Clear the expression and reset display
  void clear() {
    displayValue.value = '0';
    _expression = '';
  }

  // Calculate the result of the expression
  void calculateResult() {
    try {
      // Tokenize and evaluate the expression
      List<String> tokens = _tokenize(_expression);
      displayValue.value = _evaluate(tokens).toString();
    } catch (e) {
      displayValue.value = 'Error'; // Show error if any issues in calculation
    }
  }

  // Tokenize the expression into numbers and operators
  List<String> _tokenize(String expression) {
    List<String> tokens = [];
    String currentToken = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];

      if (RegExp(r'[0-9.]').hasMatch(char)) {
        // Build the number token (supports decimals)
        currentToken += char;
      } else if (RegExp(r'[+\-*/]').hasMatch(char)) {
        // If an operator, push the current number and operator
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = '';
        }
        tokens.add(char);
      }
    }

    // Add the last token if there is one
    if (currentToken.isNotEmpty) {
      tokens.add(currentToken);
    }

    return tokens;
  }

  // Evaluate the tokens, supporting basic operations
  double _evaluate(List<String> tokens) {
    // Convert operators to tokens and evaluate from left to right
    List<double> values = [];
    List<String> operators = [];

    for (String token in tokens) {
      if (RegExp(r'[0-9.]').hasMatch(token)) {
        // Add numbers to the values stack
        values.add(double.parse(token));
      } else if (token == '+' || token == '-' || token == '*' || token == '/') {
        operators.add(token);
      }
    }

    // Perform operations (left to right, no precedence)
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

    // Return the final result
    return values[0];
  }
}