part of 'pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<PageBloc>(context)
                                .add(GoToMainPage());
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) {
                          return Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: CircleAvatar(
                                    foregroundImage: Image(
                                      fit: BoxFit.cover,
                                      image: (userState is! UserLoaded)
                                          ? const AssetImage(
                                              'assets/images/user_pic.png')
                                          : (userState.user.profilePicture ==
                                                      null ||
                                                  userState.user
                                                          .profilePicture ==
                                                      '')
                                              ? const AssetImage(
                                                  'assets/images/user_pic.png')
                                              : NetworkImage(userState
                                                      .user.profilePicture!)
                                                  as ImageProvider,
                                    ).image,
                                    foregroundColor: Colors.transparent,
                                    backgroundColor: Colors.transparent,
                                    child: SpinKitFadingCircle(
                                      color: mainColor,
                                      size: 60,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  userState is! UserLoaded
                                      ? 'null'
                                      : (userState.user.name ?? 'No Name'),
                                  style: blackTextFont.copyWith(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  userState is UserLoaded
                                      ? userState.user.email
                                      : 'null',
                                  style: greyTextFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: defaultMargin),
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            return Column(
                              children: [
                                ProfileItemMenu(
                                  imagePath: 'assets/images/edit_profile.png',
                                  title: 'Edit Profile',
                                  onTap: () {
                                    if (userState is UserLoaded) {
                                      BlocProvider.of<PageBloc>(context).add(
                                          GoToEditProfilePage(userState.user));
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                ProfileItemMenu(
                                  imagePath: 'assets/images/my_wallet.png',
                                  title: 'My Wallet',
                                  onTap: () {
                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToWalletPage(GoToProfilePage()));
                                  },
                                ),
                                const SizedBox(height: 16),
                                const ProfileItemMenu(
                                  imagePath: 'assets/images/language.png',
                                  title: 'Change Language',
                                ),
                                const SizedBox(height: 16),
                                const ProfileItemMenu(
                                  imagePath: 'assets/images/help_centre.png',
                                  title: 'Help Centre',
                                ),
                                const SizedBox(height: 16),
                                const ProfileItemMenu(
                                  imagePath: 'assets/images/rate.png',
                                  title: 'Rate Cinematix App',
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            await AuthServices.signOut().then(
                              (_) => BlocProvider.of<UserBloc>(context)
                                  .add(SignOut()),
                            );
                          },
                          child: Text(
                            'Sign Out',
                            style: blackTextFont.copyWith(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
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

class ProfileItemMenu extends StatelessWidget {
  final String imagePath, title;
  final Function? onTap;

  const ProfileItemMenu(
      {required this.imagePath, required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (onTap == null)
              ? null
              : () {
                  onTap!();
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: 24,
                height: 24,
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: blackTextFont.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const DashLineDivider(
          height: 1,
          color: Color(0xFFE4E4E4),
        ),
      ],
    );
  }
}
