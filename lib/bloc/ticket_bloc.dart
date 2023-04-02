import 'package:cinematix/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(const TicketState([])) {
    on<TicketEvent>((event, emit) async {
      if (event is GetTickets) {
        List<Ticket> tickets = await TicketServices.getTickets(event.userID);

        emit(TicketState(tickets));
      } else if (event is BuyTicket) {
        await TicketServices.saveTicket(event.userID, event.ticket);

        List<Ticket> tickets = state.tickets + [event.ticket];

        emit(TicketState(tickets));
      }
    });
  }
}
