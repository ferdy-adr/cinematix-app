part of 'pages.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header
        Container(
          height: 110,
          padding:
              const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          decoration: BoxDecoration(
            color: accentColor1,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              if (userState is UserLoaded) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromRGBO(95, 85, 139, 1),
                          width: 1,
                        ),
                      ),
                      child: CircleAvatar(
                        child: Image(
                          image: (userState.user.profilePicture == '')
                              ? const AssetImage('assets/images/user_pic.png')
                              : Image.network(userState.user.profilePicture!)
                                  .image,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width -
                              (2 * defaultMargin) -
                              76,
                          child: Text(
                            (userState.user.name != null)
                                ? userState.user.name!
                                : 'No Name',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: whiteTextFont.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (userState.user.balance != null)
                              ? NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ',
                                ).format(userState.user.balance)
                              : 'IDR 0',
                          style: yellowNumberFont.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  color: accentColor2,
                  size: 50,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
