import '../../../settings.dart';

class CountryModel extends Country {
  const CountryModel({
    required String code,
    required String name,
    required String dialCode,
    required String flag,
  }) : super(
          code: code,
          name: name,
          dialCode: dialCode,
          flag: flag,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'],
      dialCode: json['dialCode'],
      flag: json['flag'],
      name: json['name'],
    );
  }
}

extension CountryX on Country {
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'dialCode': dialCode,
      'flag': flag,
      'name': name,
    };
  }
}
