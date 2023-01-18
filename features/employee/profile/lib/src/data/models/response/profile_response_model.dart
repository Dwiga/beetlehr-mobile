import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../models.dart';

class ProfileResponseModel extends Equatable {
  final ProfileModel data;
  final MetaData? meta;

  const ProfileResponseModel({required this.data, this.meta});

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      data: ProfileModel.fromJson(json['data']),
      meta: MetaData.fromJson(json['meta']),
    );
  }

  @override
  List<Object?> get props => [data, meta];
}
