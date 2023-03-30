part of 'services.dart';

class TicketServices {
  static final CollectionReference _ticketCollection =
      FirebaseFirestore.instance.collection('tickets');

  static Future<void> saveTicket(String userID, Ticket ticket) async {
    await _ticketCollection.doc().set({
      'movieID': ticket.movieDetail.id,
      'userID': userID,
      'theaterName': ticket.theater.name,
      'time': ticket.time.microsecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice
    });
  }

  static Future<List<Ticket>> getTickets(String userID) async {
    QuerySnapshot snapshot = await _ticketCollection.get();
    var documents =
        snapshot.docs.where((document) => document['userID'] == userID);

    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieServices.getDetails(null, movieID: document['movieID']);
      tickets.add(Ticket(
        movieDetail,
        bookingCode: document['bookingCode'],
        name: document['name'],
        theater: Theater(name: document['theaterName']),
        time: DateTime.fromMicrosecondsSinceEpoch(document['time']),
        seats: (document['seats'] as String).split(', ').toList(),
        totalPrice: document['totalPrice'],
      ));
    }

    return tickets;
  }
}
