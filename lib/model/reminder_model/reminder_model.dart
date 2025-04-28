class ReminderModel {
  final String title;
  final String? description;
  final int intervalDays;
  final DateTime createdAt;

  ReminderModel({
    required this.title,
    this.description,
    required this.intervalDays,
    required this.createdAt,
  });

  int get daysLeft {
    final targetDate = createdAt.add(Duration(days: intervalDays));
    final diff = targetDate.difference(DateTime.now()).inDays;
    return diff >= 0 ? diff : 0;
  }
}