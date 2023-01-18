/// Base model pagination
class Pagination {
  ///
  Pagination({
    this.total,
    this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  /// Total data
  final int? total;

  /// Count data current page
  final int? count;

  /// Per page in pagination
  final int perPage;

  /// Current page
  final int currentPage;

  /// Total pages
  final int totalPages;

  /// Make [Pagination] from Json
  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"] ?? 0,
        currentPage: json["current_page"] ?? 0,
        totalPages: json["total_pages"] ?? 0,
      );

  /// Convert from [Pagination] to Json
  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}
