import 'package:cinematix/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<PageEvent>((event, emit) {
      if (event is GoToSplashPage) {
        emit(OnSplashPage());
      } else if (event is GoToSignInPage) {
        emit(OnSignInPage());
      } else if (event is GoToSignUpPage) {
        emit(OnSignUpPage(event.registrationData));
      } else if (event is GoToPreferencePage) {
        emit(OnPreferencePage(event.registrationData));
      } else if (event is GoToAccountConfirmationPage) {
        emit(OnAccountConfirmationPage(event.registrationData));
      } else if (event is GoToMainPage) {
        emit(OnMainPage());
      } else if (event is GoToTicketPage) {
        emit(OnTicketPage());
      } else if (event is GoToMovieDetailPage) {
        emit(OnMovieDetailPage(event.movie));
      } else if (event is GoToSelectSchedulePage) {
        emit(OnSelectSchedulePage(event.movieDetail));
      } else if (event is GoToSelectSeatPage) {
        emit(OnSelectSeatPage(event.ticket));
      } else if (event is GoToCheckoutPage) {
        emit(OnCheckoutPage(event.ticket));
      } else if (event is GoToSuccessPage) {
        emit(OnSuccessPage(event.ticket, event.transaction));
      }
    });
  }
}
