import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/locale/app_localizations.dart';
import 'app_colors.dart';

extension StringExtension on String {
  String get removeSpaces => replaceAll(' ', '');
  int get codeFromString {
    String formattedStringColor = removeSpaces;
    if (formattedStringColor.startsWith('#')) {
      formattedStringColor = formattedStringColor.replaceAll('#', '');
    } else if (formattedStringColor.startsWith('0x')) {
      formattedStringColor = formattedStringColor.replaceAll('0x', '');
    } else if (formattedStringColor.startsWith('0X')) {
      formattedStringColor = formattedStringColor.replaceAll('0X', '');
    }
    formattedStringColor = formattedStringColor.isLengthEqual(6) ? formattedStringColor.addAtStart('FF') : formattedStringColor;
    return int.parse(formattedStringColor, radix: 16);
  }

  Color get colorFromString {
    String formattedStringColor = removeSpaces.toUpperCase();
    if (formattedStringColor.startsWith('#')) {
      formattedStringColor = formattedStringColor.replaceAll('#', '');
    } else if (formattedStringColor.startsWith('0x')) {
      formattedStringColor = formattedStringColor.replaceAll('0x', '');
    } else if (formattedStringColor.startsWith('0X')) {
      formattedStringColor = formattedStringColor.replaceAll('0X', '');
    }
    formattedStringColor = formattedStringColor.isLengthEqual(6) ? formattedStringColor.addAtStart('FF') : formattedStringColor;
    return Color(int.parse(formattedStringColor, radix: 16));
  }

  String get capitalize => toUpperCase();
  String addAtStart(String start) => "$start$this";
  bool isLengthEqual(int length) => this.length == length;
  int get toInt => int.parse(this);
  String? tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }

/*validate email*/
/*validate password*/
/*validate otp */
}


extension StringNullExtension on String? {
  String get validate => this == null ? '' : this!;
  int get toInt => validate.isEmpty ? 0 : int.parse(this!);
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}

extension IntExtension on int {
  Duration get milliseconds => Duration(milliseconds: this);
}

extension BoolExtension on bool? {
  /* null false , false false */
  bool get validate => this == null ? false : this!;
}

extension ListExtension on List<dynamic>? {
  List<dynamic> get validate => this == null ? [] : this!;
}

/* json decode and encode*/
extension MapExtension on Map<String, dynamic> {}

extension DateTimeExtension on DateTime? {
  /*validate*/
  /* string to date time */
  /* formate */
}

ButtonStyle get outlinePrimary => OutlinedButton.styleFrom(
  backgroundColor: AppColors.mainColor,
  side: const BorderSide(
    color: Colors.white,
    width: 1,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
  ),
);

ButtonStyle get defaultElevatedButtonStyle => ElevatedButton.styleFrom(
  backgroundColor: AppColors.mainColor,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      10,
    ),
  ),
);
extension DynamicExtension on dynamic{
  Map<String,dynamic> get json=>jsonDecode(this);

}
extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}