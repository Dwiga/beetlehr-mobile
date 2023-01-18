import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:files/files.dart';

class UploadFilesResponseModel extends Equatable {
  final List<NetworkFileModel> data;
  final MetaData meta;

  const UploadFilesResponseModel({
    required this.data,
    required this.meta,
  });

  factory UploadFilesResponseModel.fromJson(Map<String, dynamic> json) =>
      UploadFilesResponseModel(
        data: List<NetworkFileModel>.from(
            json["data"].map((x) => NetworkFileModel.fromJson(x))),
        meta: MetaData.fromJson(json["meta"]),
      );

  @override
  List<Object?> get props => [data, meta];
}
