class KM {
  final double value;

  KM(this.value);

  String format() {
    final formattedValue = value.toStringAsFixed(2);
    return "$formattedValue km";
  }
}
