part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageInitial extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignInPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignUpPage extends PageState {
  final RegistrationData registrationData;

  const OnSignUpPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnPreferencePage extends PageState {
  final RegistrationData registrationData;

  const OnPreferencePage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnAccountConfirmationPage extends PageState {
  final RegistrationData registrationData;

  const OnAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnTicketPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnTicketDetailPage extends PageState {
  final Ticket ticket;

  const OnTicketDetailPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class OnMovieDetailPage extends PageState {
  final Movie movie;

  const OnMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnSelectSchedulePage extends PageState {
  final MovieDetail movieDetail;

  const OnSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnSelectSeatPage extends PageState {
  final Ticket ticket;

  const OnSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class OnCheckoutPage extends PageState {
  final Ticket ticket;

  const OnCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class OnSuccessPage extends PageState {
  final Ticket ticket;
  final UserTransaction transaction;

  const OnSuccessPage(this.ticket, this.transaction);

  @override
  List<Object> get props => [ticket, transaction];
}

class OnProfilePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnEditProfilePage extends PageState {
  @override
  List<Object> get props => [];
}
