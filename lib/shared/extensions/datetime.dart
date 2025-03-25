import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabar/shared/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

enum DateTimeType {
  date,
  dateHyphen,
  dateSecondHyphen,
  dateAndTime,
  dateTimeWeekDay,
  monthly,
  dateTimeSecond,
  dateTimeSecondHyphen,
  dateTimeHyphen,
  monthHyphen,
  time,
  monthYear,
  ddMM,
  monthNameYear,
  monthName,
}

extension DateTimeTypeExtenstions on DateTimeType {
  String getDateFormat() {
    switch (this) {
      case DateTimeType.date:
        return 'dd/MM/yyyy';
      case DateTimeType.dateAndTime:
        return 'HH:mm, dd/MM/yyyy';
      case DateTimeType.dateSecondHyphen:
        return 'MM/dd/yyyy';
      case DateTimeType.dateTimeWeekDay:
        return '${DateFormat.WEEKDAY}, ${DateFormat.MONTH} ${DateFormat.DAY}, ${DateFormat.YEAR}';
      case DateTimeType.monthly:
        return 'MM/yyyy';
      case DateTimeType.dateTimeSecond:
        return 'dd/MM/yyyy HH:mm:ss';
      case DateTimeType.dateHyphen:
        return 'yyyy-MM-dd';
      case DateTimeType.dateTimeSecondHyphen:
        return 'yyyy-MM-dd HH:mm:ss';
      case DateTimeType.dateTimeHyphen:
        return 'yyyy-MM-dd HH:mm';
      case DateTimeType.monthHyphen:
        return 'yyyy-MM';
      case DateTimeType.time:
        return 'HH:mm';
      case DateTimeType.monthYear:
        return 'MM/yyyy';
      case DateTimeType.ddMM:
        return 'dd/MM';
      case DateTimeType.monthName:
        return 'MMMM';
      case DateTimeType.monthNameYear:
        return 'MMMM, yyyy';
    }
  }
}

extension DateTimeExtensions on DateTime {
  String formatLocalized({bool utc = false, required BuildContext context}) {
    final DateTime date = utc ? toUtc() : this;
    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(const Duration(days: 1));
    final String formattedDate = DateFormat('MMMM d', context.locale.languageCode).format(date);

    if (date.isSameDate(today)) {
      return '${'Today'.tr()}, $formattedDate';
    } else if (date.isSameDate(yesterday)) {
      return '${'Yesterday'.tr()}, $formattedDate';
    }
    return formattedDate;
  }

  String get getTimeAgo {
    timeago.setLocaleMessages('en_short_custom', CustomEnShortMessages());
    final String ago = timeago.format(this, locale: 'en_short_custom');
    if(ago[0] == '~') {
      return ago.substring(1);
    } else {
      return ago;
    }
  }

  String format({
    DateTimeType type = DateTimeType.date,
    bool utc = false,
  }) {
    return DateFormat(type.getDateFormat(), APP_LOCALE.languageCode)
        .format(utc ? toUtc() : this);
  }

  double getDifferenceWithoutWeekends({required DateTime endDate}) {
    double duration = 0.0;
    DateTime currentDate = this;
    while (currentDate.isBefore(endDate)) {
      if (currentDate.isWeekDay()) {
        duration = duration + 1;
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
    return duration;
  }

  DateTime firstDayInMonth() => DateTime(year, month);

  DateTime lastDayInMonth() =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

  DateTime addMonth(int step) => DateTime(
        year,
        month + step,
        day,
        hour,
        minute,
        second,
        millisecond,
        microsecond,
      );

  DateTime zeroTime() => DateTime(year, month, day);

  DateTime goToMonth(int step) =>
      firstDayInMonth().addMonth(step).firstDayInMonth();

  bool isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    final isAfter = date.isAfterOrEqualTo(fromDateTime);
    final isBefore = date.isBeforeOrEqualTo(toDateTime);
    return isAfter && isBefore;
  }

  DateTimeRange getFirstAndLastMomentToday() {
    return getFirstAndLastMoment(1);
  }

  DateTimeRange getFirstAndLastMoment(int range) {
    final startDate = zeroTime();
    final endDate = startDate.add(Duration(days: range, seconds: -1));
    return DateTimeRange(start: startDate, end: endDate);
  }

  DateTime get dateOnly => DateTime(year, month, day);

  TimeOfDay get timeOfDay {
    return TimeOfDay(
      hour: hour,
      minute: minute,
    );
  }
}

extension DateTimeStringExtensions on String {
  DateTime? toDate({required DateTimeType type, bool utc = false}) {
    try {
      return DateFormat(type.getDateFormat()).parse(this, utc);
    } on FormatException catch (_) {
      return null;
    }
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isWeekDay() {
    return !isSaturday() && !isSunday();
  }

  bool isSaturday() {
    return weekday == DateTime.saturday;
  }

  bool isSunday() {
    return weekday == DateTime.sunday;
  }
}

extension DateTimeRangeExtensions on DateTimeRange {
  int get dayWorkDuration => () {
        int day = 0;
        DateTime currentDate = start;
        while (currentDate.isBeforeOrEqualTo(end)) {
          if (currentDate.isWeekDay()) {
            day = day + 1;
          }
          currentDate = currentDate.add(const Duration(days: 1));
        }
        return day;
      }();

  String get text {
    return '${start.format()} - ${end.format()}';
  }
}

extension TimeOfDayExtension on TimeOfDay {
  String formatTime() {
    final hourFormatted = hour.toString().padLeft(2, '0');
    final minuteFormatted = minute.toString().padLeft(2, '0');
    return '$hourFormatted:$minuteFormatted';
  }

  int compareTo(TimeOfDay? other) {
    if (other == null) {
      return 1;
    }
    if (hour < other.hour) {
      return -1;
    }
    if (hour > other.hour) {
      return 1;
    }
    if (minute < other.minute) {
      return -1;
    }
    if (minute > other.minute) {
      return 1;
    }
    return 0;
  }

  TimeOfDay copyWith({
    int? hour,
    int? minute,
  }) =>
      TimeOfDay(
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
      );
}

extension TimeOfDayStringExtension on String {
  TimeOfDay? toTimeOfDay() {
    final date = DateTime.tryParse(this);
    if (date != null) {
      return TimeOfDay(
        hour: date.hour,
        minute: date.minute,
      );
    }
    return null;
  }
}

class CustomEnShortMessages extends timeago.EnShortMessages {
  @override
  String suffixAgo() => 'ago';
}
