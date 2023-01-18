enum WorkingFromType { office, anywhere }

WorkingFromType? workingFromTypefromString(String? type) {
  switch (type) {
    case 'wfa':
      return WorkingFromType.anywhere;
    case 'wfo':
      return WorkingFromType.office;
    default:
      return null;
  }
}

extension WorkFromTypeX on WorkingFromType {
  String convertToString() {
    switch (this) {
      case WorkingFromType.anywhere:
        return 'wfa';
      case WorkingFromType.office:
        return 'wfo';
    }
  }
}
