part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object?> get props => [];
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToSignUpPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  const GoToPreferencePage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  const GoToAccountConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToTicketPage extends PageEvent {
  final bool? isExpiredTickets;

  const GoToTicketPage({this.isExpiredTickets});

  @override
  List<Object?> get props => [isExpiredTickets];
}

class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;

  const GoToTicketDetailPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  const GoToMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;

  const GoToSelectSchedulePage(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;

  const GoToSelectSeatPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;

  const GoToCheckoutPage(this.ticket);

  @override
  List<Object> get props => [ticket];
}

class GoToSuccessPage extends PageEvent {
  final Ticket? ticket;
  final UserTransaction transaction;

  const GoToSuccessPage(this.ticket, this.transaction);

  @override
  List<Object?> get props => [ticket, transaction];
}

class GoToProfilePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final UserAccount userAccount;

  const GoToEditProfilePage(this.userAccount);

  @override
  List<Object> get props => [userAccount];
}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;

  /// [pageEvent] needed for back page when return to previously page.
  const GoToTopUpPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class GoToWalletPage extends PageEvent {
  final PageEvent pageEvent;

  /// [pageEvent] needed for back page when return to previously page.
  const GoToWalletPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}
