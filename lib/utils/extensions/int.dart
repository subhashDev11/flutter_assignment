import 'package:intl/intl.dart';

final _threeDigitsFormatter = NumberFormat('#,###');

extension IntExtension on int {

  String get withComma => _threeDigitsFormatter.format(this);

  String toJpy(int number) => '${_threeDigitsFormatter.format(number)} 円';
}
