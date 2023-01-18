import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../attendance.dart';

class CheckPlacementResponseModel extends Equatable {
  final OfficePlacementModel data;
  final MetaData? meta;

  const CheckPlacementResponseModel({
    required this.data,
    this.meta,
  });

  factory CheckPlacementResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckPlacementResponseModel(
        data: OfficePlacementModel.fromJson(json["data"]),
        meta: json['meta'] != null ? MetaData.fromJson(json["meta"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "meta": meta?.toJson(),
      };

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
