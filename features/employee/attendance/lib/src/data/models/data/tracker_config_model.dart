import 'package:dependencies/dependencies.dart';

class TrackerConfigModel extends Equatable {
  final bool isEnabled;
  final String url;

  const TrackerConfigModel({
    required this.isEnabled,
    required this.url,
  });

  factory TrackerConfigModel.fromJson(Map<String, dynamic> json) {
    return TrackerConfigModel(
      isEnabled: json['is_enabled'] ?? false,
      url: json['tracker_endpoint'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_enabled': isEnabled,
      'tracker_endpoint': url,
    };
  }

  @override
  List<Object?> get props => [isEnabled, url];
}
