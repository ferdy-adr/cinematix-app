part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTickets extends TicketEvent {
  final String userID;

  const GetTickets(this.userID);

  @override
  List<Object> get props => [userID];
}

class BuyTicket extends TicketEvent {
  final String userID;
  final Ticket ticket;

  const BuyTicket(this.userID, this.ticket);

  @override
  List<Object> get props => [userID];
}
