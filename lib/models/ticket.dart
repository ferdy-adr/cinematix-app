part of 'models.dart';

class Ticket extends Equatable {
  final MovieDetail movieDetail;
  final String bookingCode, name;
  final Theater theater;
  final DateTime time;
  final List<String>? seats;
  final int? totalPrice;

  const Ticket(this.movieDetail,
      {required this.bookingCode,
      required this.name,
      required this.theater,
      required this.time,
      this.seats,
      this.totalPrice});

  Ticket copyWith(
      {MovieDetail? movieDetail,
      String? bookingCode,
      String? name,
      Theater? theater,
      DateTime? time,
      List<String>? seats,
      int? totalPrice}) {
    return Ticket(movieDetail ?? this.movieDetail,
        bookingCode: bookingCode ?? this.bookingCode,
        name: name ?? this.name,
        theater: theater ?? this.theater,
        time: time ?? this.time,
        seats: seats ?? this.seats,
        totalPrice: totalPrice ?? this.totalPrice);
  }

  String get seatsInString {
    String s = '';

    if (seats != null) {
      for (var i = 0; i < seats!.length; i++) {
        s += seats![i] + ((i != seats!.length - 1) ? ', ' : '');
      }
    }

    return s;
  }

  @override
  List<Object?> get props =>
      [movieDetail, bookingCode, name, theater, time, seats, totalPrice];
}
