extension DateTimeExtension on DateTime {
  String timeAgo() {
    final Duration difference = DateTime.now().difference(this);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          final int seconds = difference.inSeconds;
          return '$seconds ${seconds == 1 ? 'giây' : 'giây'} trước';
        } else {
          final int minutes = difference.inMinutes;
          return '$minutes ${minutes == 1 ? 'phút' : 'phút'} trước';
        }
      } else {
        final int hours = difference.inHours;
        return '$hours ${hours == 1 ? 'giờ' : 'giờ'} trước';
      }
    } else {
      final int days = difference.inDays;
      return '$days ${days == 1 ? 'ngày' : 'ngày'} trước';
    }
  }
}
