import 'dart:math';

extension DoubleExt on double {
  double toPrecision(int fractionDigits) {
    final mod = pow(10, fractionDigits.toDouble()).toDouble();
    return (this * mod).round().toDouble() / mod;
  }

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get ms => milliseconds;

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());

  String toText({int fractionDigit = 1, String? prefix}) {
    String formattedNumber = toStringAsFixed(fractionDigit);

    if (formattedNumber.contains('.') && formattedNumber.endsWith('0')) {
      formattedNumber = formattedNumber.replaceAll(RegExp(r'0*$'), '');
    }

    if (formattedNumber.endsWith('.')) {
      formattedNumber =
          formattedNumber.substring(0, formattedNumber.length - 1);
    }

    if (prefix == null) {
      return formattedNumber;
    }
    if (this > 1) {
      // return '$prefix.other'.tr(args: [formattedNumber]);
      throw const FormatException('convert');
    }
    // return '$prefix.one'.tr(args: [formattedNumber]);
    throw const FormatException('convert');
  }
}
