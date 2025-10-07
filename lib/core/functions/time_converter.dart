String convertTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inMinutes < 60) {
    final m = difference.inMinutes;
    return "$m ${m == 1 ? 'minute' : 'minutes'} ago";
  } else if (difference.inHours < 24) {
    final h = difference.inHours;
    return "$h ${h == 1 ? 'hour' : 'hours'} ago";
  } else {
    final d = difference.inDays;
    return "$d ${d == 1 ? 'day' : 'days'} ago";
  }
}
