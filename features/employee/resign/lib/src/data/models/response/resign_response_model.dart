import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../data/resign_model.dart';

class ResignResponseModel extends Equatable {
  const ResignResponseModel({
    required this.data,
    this.meta,
  });

  final ResignModel? data;
  final MetaData? meta;

  factory ResignResponseModel.fromJson(Map<String, dynamic> json) =>
      ResignResponseModel(
        data: json["data"] != null && json['data']['id'] != null
            ? ResignModel.fromJson(json["data"])
            : null,
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  @override
  List<Object?> get props => [data, meta];
}
