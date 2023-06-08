class RomanNumeralsConverter {
  static const romanValues = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000,
  };

  static const _numbers = [
    1,
    4,
    5,
    9,
    10,
    40,
    50,
    90,
    100,
    400,
    500,
    900,
    1000
  ];
  static const _symbols = [
    "I",
    "IV",
    "V",
    "IX",
    "X",
    "XL",
    "L",
    "XC",
    "C",
    "CD",
    "D",
    "CM",
    "M"
  ];

  static int toDecimal(String roman) {
    return _romanToDecimal(roman);
  }

  static String toRoman(int decimal) {
    return _decimalToRoman(decimal);
  }

  static int _numeralValue(String char) {
    final value = romanValues[char];
    if (value == null) {
      return -1;
    }
    return value;
  }

  static int _romanToDecimal(String roman) {
    var res = 0;
    for (var i = 0; i < roman.length; i++) {
      var value1 = _numeralValue(roman[i]);
      if (i + 1 < roman.length) {
        var value2 = _numeralValue(roman[i + 1]);
        if (value1 >= value2) {
          res = res + value1;
        } else {
          res = res + value2 - value1;
          i++;
        }
      } else {
        res = res + value1;
      }
    }
    return res;
  }

  static String _decimalToRoman(int decimal) {
    var number = decimal;
    var i = _numbers.length - 1;
    var roman = StringBuffer();
    while (number > 0) {
      var div = number ~/ _numbers[i];
      number = number % _numbers[i];
      while (div-- > 0) {
        roman.write(_symbols[i]);
      }
      i--;
    }
    return roman.toString();
  }
}