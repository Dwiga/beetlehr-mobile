enum PayrollStatus { generated, paid }

class PayrollStatusConverter {
  static PayrollStatus? fromString(String? v) {
    switch (v) {
      case 'Generated':
        return PayrollStatus.generated;
      case 'Paid':
        return PayrollStatus.paid;
      default:
        return null;
    }
  }

  static String? convertToString(PayrollStatus? v) {
    switch (v) {
      case PayrollStatus.generated:
        return 'Generated';
      case PayrollStatus.paid:
        return 'Paid';
      default:
        return null;
    }
  }
}
