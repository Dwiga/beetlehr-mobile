enum BreakTimeType { start, end }

BreakTimeType? breakTimeTypefromString(String? type) {
  switch (type) {
    case 'start':
      return BreakTimeType.start;
    case 'end':
      return BreakTimeType.end;
    default:
      return null;
  }
}

extension BreakTimeTypeX on BreakTimeType {
  String convertToString() {
    switch (this) {
      case BreakTimeType.start:
        return 'start';
      case BreakTimeType.end:
        return 'end';
    }
  }
}
