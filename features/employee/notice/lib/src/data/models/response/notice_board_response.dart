import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

import '../../../../notice.dart';

class NoticeBoardResponseModel extends Equatable {
  final List<NoticeModel> data;
  final MetaData? meta;
  const NoticeBoardResponseModel({
    required this.data,
    this.meta,
  });

  factory NoticeBoardResponseModel.fromJson(Map<String, dynamic> json) {
    return NoticeBoardResponseModel(
      data: json['data'] != null
          ? List<NoticeModel>.from(
              json["data"].map((x) => NoticeModel.fromJson(x)))
          : [],
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }

  @override
  List<Object?> get props => [data, meta];

  @override
  bool get stringify => true;
}
