part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  const AccountConfirmationPage(this.registrationData, {super.key});

  @override
  State<AccountConfirmationPage> createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToPreferencePage(widget.registrationData));

        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 56,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PageBloc>(context).add(
                                      GoToPreferencePage(
                                          widget.registrationData));
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Confirm\nNew Account',
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
                      const SizedBox(height: 90),
                      CircleAvatar(
                        radius: 75,
                        backgroundImage: Image(
                          image: (widget.registrationData.profilePicture !=
                                  null)
                              ? FileImage(
                                  widget.registrationData.profilePicture!)
                              : const AssetImage('assets/images/user_pic.png')
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome',
                        style: blackTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          height: 1.4,
                        ),
                      ),
                      Text(
                        widget.registrationData.name,
                        style: blackTextFont.copyWith(
                          fontSize: 20,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 110),
                      (isSigningUp != true)
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  (2 * (defaultMargin + 31)),
                              height: 46,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isSigningUp = true;
                                  });

                                  SignInSignUpResult result =
                                      await AuthServices.signUp(
                                          widget.registrationData.email,
                                          widget.registrationData.password,
                                          widget.registrationData.name,
                                          widget.registrationData.selectedGenre,
                                          widget.registrationData
                                              .selectedLanguage);

                                  // Map for match image by email address
                                  if (result.user != null) {
                                    imageFileToUpload['uid'] = result.user?.id;
                                    imageFileToUpload['profilePicture'] =
                                        widget.registrationData.profilePicture;
                                  }

                                  if (result.user == null) {
                                    setState(() {
                                      isSigningUp = false;
                                    });

                                    if (context.mounted) {
                                      Flushbar(
                                        messageText: Text(
                                          result.message.toString(),
                                          style: whiteTextFont.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        duration: const Duration(seconds: 4),
                                        backgroundColor:
                                            const Color(0xFFFF5C83),
                                        flushbarPosition: FlushbarPosition.TOP,
                                      ).show(context);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF3E9D9D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Create My Account',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            )
                          : SpinKitFadingCircle(
                              color: mainColor,
                            ),
                      const SizedBox(height: 70),
                    ],
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
