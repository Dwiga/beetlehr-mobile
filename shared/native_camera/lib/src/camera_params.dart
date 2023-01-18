import 'enum/lens_type.dart';

class CameraParams {
  final LensType lensType;
  final double maxIOSSize;

  CameraParams({
    this.lensType = LensType.all,
    this.maxIOSSize = 400,
  });

  Map<String, dynamic> toMap() {
    return {
      'lens_type': lensType.toType,
      'max_ios_size': maxIOSSize,
    };
  }
}
