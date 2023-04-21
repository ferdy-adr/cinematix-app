part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final UserAccount userAccount;

  const EditProfilePage(this.userAccount, {super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isUpdated = false;

  String? profilePicture;
  File? changedPicture;
  bool isPictureChanged = false;
  bool isLoadSpinkit = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userAccount.name ?? '';
    emailController.text = widget.userAccount.email;
    profilePicture = (widget.userAccount.profilePicture == null ||
            widget.userAccount.profilePicture == '')
        ? null
        : widget.userAccount.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    if (!isPictureChanged &&
        nameController.text.trim() == widget.userAccount.name &&
        emailController.text.trim() == widget.userAccount.email &&
        passwordController.text.trim() == '') {
      isUpdated = false;
    } else {
      isUpdated = true;
    }

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToProfilePage());
        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Your\nProfile',
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PageBloc>(context)
                                      .add(GoToProfilePage());
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
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
                                child: (!isPictureChanged)
                                    ? ((profilePicture != null)
                                        ? CircleAvatar(
                                            backgroundImage: Image(
                                              image:
                                                  NetworkImage(profilePicture!),
                                              fit: BoxFit.cover,
                                            ).image,
                                          )
                                        : const Image(
                                            image: AssetImage(
                                              'assets/images/user_pic.png',
                                            ),
                                          ))
                                    : ((changedPicture != null)
                                        ? CircleAvatar(
                                            backgroundImage: Image(
                                              image: FileImage(changedPicture!),
                                              fit: BoxFit.cover,
                                            ).image,
                                          )
                                        : const Image(
                                            image: AssetImage(
                                              'assets/images/user_pic.png',
                                            ),
                                          )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePicture != null) {
                                    setState(() {
                                      profilePicture = null;
                                      isPictureChanged = true;
                                    });
                                  } else {
                                    changedPicture = await getImage();

                                    if (changedPicture != null) {
                                      isPictureChanged = true;
                                    }

                                    setState(() {});
                                  }
                                },
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Image(
                                    image: AssetImage(
                                      (profilePicture != null)
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
                      (!isLoadSpinkit)
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  (2 * (defaultMargin + 31)),
                              height: 45,
                              child: ElevatedButton(
                                onPressed: (!isUpdated)
                                    ? null
                                    : () async {
                                        if (nameController.text.trim() == '' ||
                                            emailController.text.trim() == '') {
                                          Flushbar(
                                            messageText: Text(
                                              'Please fill name or email fields',
                                              style: whiteTextFont.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            duration:
                                                const Duration(seconds: 4),
                                            backgroundColor:
                                                const Color(0xFFFF5C83),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                        } else if (passwordController.text !=
                                            '') {
                                          if (passwordController.text !=
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
                                              duration:
                                                  const Duration(seconds: 4),
                                              backgroundColor:
                                                  const Color(0xFFFF5C83),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                            ).show(context);
                                          } else if (passwordController
                                                  .text.length <
                                              6) {
                                            Flushbar(
                                              messageText: Text(
                                                'Password\'s length min 6 characters',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              duration:
                                                  const Duration(seconds: 4),
                                              backgroundColor:
                                                  const Color(0xFFFF5C83),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                            ).show(context);
                                          }
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
                                            duration:
                                                const Duration(seconds: 4),
                                            backgroundColor:
                                                const Color(0xFFFF5C83),
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                          ).show(context);
                                        } else {
                                          setState(() {
                                            isLoadSpinkit = true;
                                          });

                                          String? changedPictureURL;
                                          bool isDeleteProfilePicture = false;

                                          if (isPictureChanged &&
                                              changedPicture != null) {
                                            changedPictureURL =
                                                await uploadImage(
                                                    changedPicture!);
                                          } else if (widget.userAccount
                                                      .profilePicture !=
                                                  null &&
                                              isPictureChanged &&
                                              changedPicture == null) {
                                            await deleteImage(widget
                                                .userAccount.profilePicture!);
                                            isDeleteProfilePicture = true;
                                          }

                                          if (context.mounted) {
                                            BlocProvider.of<UserBloc>(context)
                                                .add(UpdateData(
                                                    name: nameController.text,
                                                    profilePicture:
                                                        changedPictureURL,
                                                    deleteProfilePicture:
                                                        isDeleteProfilePicture));

                                            setState(() {
                                              isLoadSpinkit = false;
                                            });

                                            BlocProvider.of<PageBloc>(context)
                                                .add(GoToProfilePage());
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                  backgroundColor: (!isUpdated)
                                      ? const Color(0xFFE4E4E4)
                                      : const Color(0xFF3E9D9D),
                                ),
                                child: Text(
                                  'Update My Profile',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    height: 1.375,
                                    color: (!isUpdated)
                                        ? const Color(0xFFBEBEBE)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SpinKitFadingCircle(
                              color: mainColor,
                              size: 45,
                            ),
                      const SizedBox(height: 40),
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
