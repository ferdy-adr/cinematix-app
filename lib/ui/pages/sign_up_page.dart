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
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child:
                                      (widget.registrationData.profilePicture !=
                                              null)
                                          ? CircleAvatar(
                                              backgroundImage: Image(
                                                image: FileImage(
                                                  widget.registrationData
                                                      .profilePicture!,
                                                ),
                                                fit: BoxFit.cover,
                                              ).image,
                                            )
                                          : const Image(
                                              image: AssetImage(
                                                'assets/images/user_pic.png',
                                              ),
                                            ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (widget
                                            .registrationData.profilePicture ==
                                        null) {
                                      widget.registrationData.profilePicture =
                                          await getImage();
                                    } else {
                                      widget.registrationData.profilePicture =
                                          null;
                                    }

                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: Image(
                                      image: AssetImage(
                                        (widget.registrationData
                                                    .profilePicture !=
                                                null)
                                            ? 'assets/images/btn_del_photo.png'
                                            : 'assets/images/btn_add_photo.png',
                                      ),
                                    ),
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
                          onPressed: () {
                            if (nameController.text.trim() == '' &&
                                emailController.text.trim() == '' &&
                                passwordController.text.trim() == '' &&
                                confirmPasswordController.text.trim() == '') {
                              Flushbar(
                                messageText: Text(
                                  'Please fill all the fields',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 4),
                                backgroundColor: const Color(0xFFFF5C83),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              Flushbar(
                                messageText: Text(
                                  'Mismatch password and confirmed password',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 4),
                                backgroundColor: const Color(0xFFFF5C83),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else if (passwordController.text.length < 6) {
                              Flushbar(
                                messageText: Text(
                                  'Password\'s length min 6 characters',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 4),
                                backgroundColor: const Color(0xFFFF5C83),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else if (!EmailValidator.validate(
                                emailController.text)) {
                              Flushbar(
                                messageText: Text(
                                  'Wrong formatted email address',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                duration: const Duration(seconds: 4),
                                backgroundColor: const Color(0xFFFF5C83),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            } else {
                              widget.registrationData.name =
                                  nameController.text;
                              widget.registrationData.email =
                                  emailController.text;
                              widget.registrationData.password =
                                  passwordController.text;

                              BlocProvider.of<PageBloc>(context).add(
                                  GoToPreferencePage(widget.registrationData));
                            }
                          },
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
