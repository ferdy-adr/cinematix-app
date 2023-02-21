part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 67,
                            height: 70,
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome Back,\nExplorer!',
                            style: blackTextFont.copyWith(
                              fontSize: 20,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              isEmailValid = EmailValidator.validate(value);
                            });
                          },
                          controller: emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              isPasswordValid = value.length >= 6;
                            });
                          },
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Forgot Password?',
                              style: greyTextFont.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                ' Get Now',
                                style: purpleTextFont.copyWith(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        (isSigningIn)
                            ? SpinKitFadingCircle(
                                color: mainColor,
                              )
                            : FloatingActionButton(
                                onPressed: (isEmailValid && isPasswordValid)
                                    ? () async {
                                        setState(() {
                                          isSigningIn = true;
                                        });

                                        await AuthServices.signIn(
                                                emailController.value.text,
                                                passwordController.value.text)
                                            .then((value) {
                                          if (value.user == null) {
                                            setState(() {
                                              isSigningIn = false;
                                            });

                                            Flushbar(
                                              messageText: Text(
                                                value.message ?? '',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              duration:
                                                  const Duration(seconds: 4),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      255, 92, 131, 1),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                            ).show(context);
                                          }
                                        });
                                      }
                                    : null,
                                elevation: 0,
                                backgroundColor: (isEmailValid &&
                                        isPasswordValid)
                                    ? mainColor
                                    : const Color.fromRGBO(228, 228, 228, 1),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: (isEmailValid && isPasswordValid)
                                      ? Colors.white
                                      : const Color.fromRGBO(190, 190, 190, 1),
                                  size: 24,
                                ),
                              ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start fresh now?',
                              style: greyTextFont.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                ' Sign Up',
                                style: purpleTextFont.copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
