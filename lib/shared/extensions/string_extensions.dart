extension StringExt on String? {
  String? quoted() {
    if(this == null) {
      return null;
    }
    return '''"$this"''';
  }

  bool isEmptyString() {
    return (this ?? '').isEmpty;
  }

  bool isNotEmpty() {
    return (this ?? '').isNotEmpty;
  }

  String capitalize() {
    final text = this ?? '';
    if (text.isEmpty) {
      return '';
    }

    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  int? get toInt {
    return this == null
        ? null
        : int.tryParse(this?.replaceAll(RegExp(r'\D'), '') ?? '');
  }

}

extension StringNotNullExt on String{
  String uppercaseFirstLetter() {
    return this[0].toUpperCase() + substring(1);
  }
}
