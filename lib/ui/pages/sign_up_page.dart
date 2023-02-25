part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  const SignUpPage(this.registrationData, {super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(
      ChangeTheme(ThemeData(primarySwatch: accentColor2.getMaterialColor())),
    );

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
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 22),
                          height: 56,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToSplashPage());
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    size: 24,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Create New\nYour Account',
                                  textAlign: TextAlign.center,
                                  style: blackTextFont.copyWith(
                                    fontSize: 20,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 90,
                          height: 102,
                          child: Stack(
                            children: const [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/user_pic.png'),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/btn_add_photo.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        TextField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        TextField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 27),
                        TextField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(width: 1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        FloatingActionButton(
                          onPressed: () {},
                          elevation: 0,
                          backgroundColor: const Color(0xFF503E9D),
                          child: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                        const SizedBox(height: 40),
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
