part of 'pages.dart';

class AccountConfirmationPage extends StatelessWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage(this.registrationData, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToPreferencePage(registrationData));

        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Container(
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
