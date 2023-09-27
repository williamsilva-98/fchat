extension DateTimeExtensions on DateTime {
  /// Returns a String with the hour and minute.
  /// ```dart
  /// final date = DateTime.now();
  /// print(date.hhmm()); // 10:30
  /// ```
  String hhmm() {
    final hour = this.hour < 10 ? '0${this.hour}' : '${this.hour}';
    final minute = this.minute < 10 ? '0${this.minute}' : '${this.minute}';
    return '$hour:$minute';
  }
}
