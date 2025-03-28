extension DurationExt on int {
  Duration get seconds => Duration(seconds: this);

  Duration get days => Duration(days: this);

  Duration get hours => Duration(hours: this);

  Duration get minutes => Duration(minutes: this);

  Duration get milliseconds => Duration(milliseconds: this);

  Duration get microseconds => Duration(microseconds: this);

  Duration get ms => milliseconds;
}

extension StringExt on int {
  String get shortNumber {
    if (this < 1000) {
      return toString();
    } else if (this < 1000000) {
      return '${(this / 1000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}K';
    } else if (this < 1000000000) {
      return '${(this / 1000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}M';
    } else {
      return '${(this / 1000000000).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}B';
    }
  }
}
