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
                                    backgroundImage: Image(
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (_, child, loadingProgress) {
                                        if (loadingProgress != null &&
                                            loadingProgress
                                                    .cumulativeBytesLoaded !=
                                                loadingProgress
                                                    .expectedTotalBytes) {
                                          return SpinKitFadingCircle(
                                            color: mainColor,
                                            size: 50,
                                          );
                                        } else {
                                          return child;
                                        }
                                      },
                                      image: NetworkImage(
                                          userState is UserLoaded
                                              ? userState.user.profilePicture!
                                              : ''),
                                    ).image,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
