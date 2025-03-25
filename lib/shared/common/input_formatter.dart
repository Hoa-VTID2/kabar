import 'package:flutter/services.dart';
import 'package:kabar/shared/extensions/number_extensions.dart';
import 'package:kabar/shared/extensions/string_extensions.dart';

class SeparateNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final formattedValue = newValue.text.toInt?.toCurrencyString ?? '';

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection(
        baseOffset: formattedValue.length,
        extentOffset: formattedValue.length,
      ),
    );
  }
}

class NameFormmater extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final formattedValue = newValue.text.replaceAll(
      RegExp(
          r'[^a-zA-Z\sÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ]'),
      '',
    );

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection(
        baseOffset: formattedValue.length,
        extentOffset: formattedValue.length,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
