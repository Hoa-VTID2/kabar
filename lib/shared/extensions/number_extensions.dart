import 'package:easy_localization/easy_localization.dart';
import 'package:kabar/shared/constants.dart';

extension NumberExtension on num {
  String get toCurrencyString =>
      NumberFormat('###,###,###,###,###', APP_LOCALE.languageCode).format(this);
}
