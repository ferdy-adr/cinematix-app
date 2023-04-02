part of 'models.dart';

class UserTransaction extends Equatable {
  final String userID, title, subtitle;
  final int amount;
  final DateTime time;
  final String? picture;

  const UserTransaction(
      {required this.userID,
      required this.title,
      required this.subtitle,
      this.amount = 0,
      required this.time,
      this.picture});

  @override
  List<Object?> get props => [userID, title, subtitle, amount, time, picture];
}
