import 'package:dependencies/dependencies.dart';

class Country extends Equatable {
  final String code;
  final String name;
  final String dialCode;
  final String flag;

  const Country({
    required this.code,
    required this.name,
    required this.dialCode,
    required this.flag,
  });

  @override
  List<Object> get props => [code, name, dialCode, flag];

  @override
  bool get stringify => true;
}
