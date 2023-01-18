/// Generic class for paginate data
class PaginateData<T, MetaData> {
  /// Data Type
  final T data;

  /// Meta Data
  final MetaData? meta;

  ///
  PaginateData({required this.data, this.meta});
}
