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
    // Replace the last operator if one already exists
    if (_expression.isNotEmpty && RegExp(r'[+\-*/÷×%]$').hasMatch(_expression)) {
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
      final result = _evaluate(tokens);

      if (result == result.toInt()) {
        finalResult = result.toInt().toString(); // Show integer if result is whole
      } else {
        finalResult = result.toString();
      }

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
      } else if (RegExp(r'[+\-*/÷×%]').hasMatch(char)) {
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
    // Process multiplication, division, and remainder first
    tokens = _processMultiplicationDivision(tokens);

    // Then process addition and subtraction
    tokens = _processAdditionSubtraction(tokens);

    // The remaining token is the result
    return double.parse(tokens[0]);
  }

  List<String> _processMultiplicationDivision(List<String> tokens) {
    int i = 0;
    while (i < tokens.length) {
      if (tokens[i] == '*' || tokens[i] == '×' || tokens[i] == '/' || tokens[i] == '÷' || tokens[i] == '%') {
        double left = double.parse(tokens[i - 1]);
        double right = double.parse(tokens[i + 1]);
        double result;

        if (tokens[i] == '*' || tokens[i] == '×') {
          result = left * right;
        } else if (tokens[i] == '/' || tokens[i] == '÷') {
          if (right == 0) {
            throw FormatException('Cannot divide by zero');
          }
          result = left / right;
        } else if (tokens[i] == '%') {
          if (right == 0) {
            throw FormatException('Cannot divide by zero in modulus');
          }
          result = left % right;
        } else {
          throw FormatException('Invalid operator');
        }

        // Replace the left operand with the result
        tokens[i - 1] = result.toString();
        // Remove the operator and the right operand
        tokens.removeAt(i);
        tokens.removeAt(i);

        // Move back one step to recheck the current operator
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
          throw FormatException('Invalid operator');
        }

        // Replace the left operand with the result
        tokens[i - 1] = result.toString();
        // Remove the operator and the right operand
        tokens.removeAt(i);
        tokens.removeAt(i);

        // Move back one step to recheck the current operator
        i--;
      }
      i++;
    }
    return tokens;
  }
}
