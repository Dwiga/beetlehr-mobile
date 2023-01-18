import 'package:dependencies/dependencies.dart';

class ApproverRequestBodyModel extends Equatable {
  const ApproverRequestBodyModel({this.reason, required this.type});

  final String? reason;
  final String type;

  Map<String, dynamic> toJson() => {"reason": reason, "type": type};

  @override
  List<Object?> get props => [reason, type];

  @override
  bool get stringify => true;
}
