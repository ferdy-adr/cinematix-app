part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitebackgroundColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const SizedBox(
                      width: 130,
                      height: 136,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 70),
                    Text(
                      'New Experience',
                      textAlign: TextAlign.center,
                      style: blackTextFont.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Watch a new movie much\neasier than any before',
                      textAlign: TextAlign.center,
                      style: greyTextFont.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      width: 250,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(const GoToSignUpPage(RegistrationData()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Get Started',
                          style: whiteTextFont.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: greyTextFont.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<PageBloc>(context)
                                .add(GoToSignInPage());
                          },
                          child: Text(
                            ' Sign In',
                            style: purpleTextFont.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
