class IndonesianMotorPlateNumberUtil {
  static bool check(String plateNumber) {
    // Format plat nomor motor di Indonesia: 1-4 huruf, 1-3 angka, 0-2 huruf
    // Contoh format yang benar: B1234XY, AB123X, C1
    RegExp motorPlatePattern = RegExp(r'^[A-Z]{1,4}\s*\d{1,3}\s*[A-Z]{0,2}$');
    return motorPlatePattern.hasMatch(plateNumber);
  }
}
