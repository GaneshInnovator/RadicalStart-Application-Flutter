// lib/calculator_logic.dart

class CalculatorLogic {
double _currentValue = 0;
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
if (_operator.isEmpty) {
_memory = double.tryParse(displayValue) ?? 0;
_operator = operator;
displayValue = '0';
} else {
_calculate();
_operator = operator;
}
}

void calculateResult() {
_calculate();
_operator = '';
}

void clear() {
displayValue = '0';
_currentValue = 0;
_operator = '';
_memory = 0;
}

void _calculate() {
double current = double.tryParse(displayValue) ?? 0;
switch (_operator) {
case '+':
_memory += current;
break;
case '-':
_memory -= current;
break;
case '*':
_memory *= current;
break;
case '/':
if (current != 0) {
_memory /= current;
} else {
displayValue = 'Error';
return;
}
break;
default:
return;
}
displayValue = _memory.toString();
}
}