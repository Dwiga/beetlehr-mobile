import 'package:dependencies/dependencies.dart';

class ClockAcceptModel extends Equatable {
  const ClockAcceptModel({
    this.isLate,
    this.acceptedLocation,
    this.acceptedImage,
  });

  final bool? isLate;
  final bool? acceptedLocation;
  final bool? acceptedImage;

  factory ClockAcceptModel.fromJson(Map<String, dynamic> json) =>
      ClockAcceptModel(
        isLate: json["is_late"],
        acceptedLocation: json["accepted_location"],
        acceptedImage: json["accepted_image"],
      );

  Map<String, dynamic> toJson() => {
        "is_late": isLate,
        "accepted_location": acceptedLocation,
        "accepted_image": acceptedImage,
      };

  @override
  List<Object?> get props => [isLate, acceptedImage, acceptedLocation];

  @override
  bool? get stringify => true;
}
