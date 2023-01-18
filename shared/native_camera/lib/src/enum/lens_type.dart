/// Camera-camera lens type
enum LensType {
  /// Front camera
  front,

  /// Back camera
  back,

  /// Can use front & back
  all
}

extension LensTypeX on LensType {
  int get toType => this.index;
}
