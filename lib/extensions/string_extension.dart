part of 'extensions.dart';

extension StringExtension on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  bool isDigit(int index) {
    return (codeUnitAt(index) >= 48 && codeUnitAt(index) <= 57) ? true : false;
  }
}
