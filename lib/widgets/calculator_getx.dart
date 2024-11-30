import 'package:get/get.dart';

class CalculatorLogic extends GetxController {
  var displayValue = '0'.obs;

  void inputNumber(String value) {
    if (displayValue.value == '0') {
      displayValue.value = value;
    } else {
      displayValue.value += value;
    }
  }

  void inputOperator(String value) {
    displayValue.value += value;
  }

  void clear() {
    displayValue.value = '0';
  }

  void calculateResult() {
    try {
      // Simple eval logic for calculation
      displayValue.value = (int.parse(displayValue.value)).toString(); // Just an example
    } catch (e) {
      displayValue.value = 'Error';
    }
  }
}