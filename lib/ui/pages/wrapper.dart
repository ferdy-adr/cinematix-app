part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = Provider.of<User?>(context);

    if (firebaseUser == null) {
      if (prevPageEvent is! GoToSplashPage) {
        prevPageEvent = GoToSplashPage();
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
      }
    } else {
      if (prevPageEvent is! GoToMainPage) {
        prevPageEvent = GoToMainPage();
        BlocProvider.of<UserBloc>(context).add(LoadUser(firebaseUser.uid));
        BlocProvider.of<TicketBloc>(context).add(GetTickets(firebaseUser.uid));
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (_, pageState) {
        if (pageState is OnSplashPage) {
          return const SplashPage();
        } else if (pageState is OnSignInPage) {
          return const SignInPage();
        } else if (pageState is OnSignUpPage) {
          return SignUpPage(pageState.registrationData);
        } else if (pageState is OnPreferencePage) {
          return PreferencePage(pageState.registrationData);
        } else if (pageState is OnAccountConfirmationPage) {
          return AccountConfirmationPage(pageState.registrationData);
        } else if (pageState is OnMovieDetailPage) {
          return MovieDetailPage(pageState.movie);
        } else if (pageState is OnSelectSchedulePage) {
          return SelectSchedulePage(pageState.movieDetail);
        } else if (pageState is OnSelectSeatPage) {
          return SelectSeatPage(pageState.ticket);
        } else if (pageState is OnCheckoutPage) {
          return CheckoutPage(pageState.ticket);
        } else if (pageState is OnSuccessPage) {
          return SuccessPage(pageState.ticket, pageState.transaction);
        } else if (pageState is OnTicketPage) {
          return const MainPage(
              initialPageView: MainPageInitialPageView.ticketPage);
        } else if (pageState is OnTicketDetailPage) {
          return TicketDetailPage(pageState.ticket);
        } else {
          return const MainPage();
        }
      },
    );
  }
}
