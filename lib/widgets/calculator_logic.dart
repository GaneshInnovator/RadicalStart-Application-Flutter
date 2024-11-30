class CalculatorLogic {
  double current = 0;
  String _operator = '';
  double _memory = 0;

  String displayValue = '0';

  void inputNumber(String number) {
    if (displayValue == '0' || displayValue == 'Error') {
      displayValue = number;
    } else {
      displayValue += number;
    }
  }

  void inputOperator(String operator) {
    if (operator == '÷') {
      operator = '/';
    } else if (operator == '×') {
      operator = '*';
    }

    if (_operator.isNotEmpty) {
      _calculate();
    }

    _operator = operator;
    _memory = double.tryParse(displayValue) ?? 0;
  }

  void calculateResult() {
    if (_operator.isNotEmpty) {
      _calculate(); // Perform the calculation
      _operator = ''; // Clear the operator after calculation
    }
  }

  void clear() {
    displayValue = '0';
    current = 0;
    _operator = '';
    _memory = 0;
  }

  void _calculate() {
    double currentValue = double.tryParse(displayValue) ?? 0;  // Using a new variable to avoid confusion with the class variable

    switch (_operator) {
      case '+':
        _memory += currentValue;
        break;
      case '-':
        _memory -= currentValue;
        break;
      case '*':
        _memory *= currentValue;
        break;
      case '/':
        if (currentValue != 0) {
          _memory /= currentValue;
        } else {
          displayValue = 'Error'; // Handle division by zero
          return;
        }
        break;
      default:
        return;
    }
    displayValue = _memory.toString();; // Update the display value after calculation
  }
}