
extension FormatNumber on int? {
  String? formatCurrency() {
    if (this == null) {
      return null;
    }

    final String formatted = toString();
    if (formatted.length <= 3) {
      return formatted;
    }

    int dotIndex = formatted.length % 3;
    if (dotIndex == 0) {
      dotIndex = 3;
    }

    StringBuffer result = StringBuffer(formatted.substring(0, dotIndex));
    while (dotIndex < formatted.length) {
      result.write('.');
      result.write(formatted.substring(dotIndex, dotIndex + 3));
      dotIndex += 3;
    }

    return result.toString();
  }
}
