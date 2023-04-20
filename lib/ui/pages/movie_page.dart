part of 'pages.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // section: HEADER
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
            builder: (context, userState) {
              if (userState is UserLoaded) {
                if (imageFileToUpload['profilePicture'] != null &&
                    imageFileToUpload['uid'] == userState.user.id) {
                  uploadImage(imageFileToUpload['profilePicture'])
                      .then((downloadURL) {
                    imageFileToUpload.updateAll((key, value) => value = null);

                    BlocProvider.of<UserBloc>(context)
                        .add(UpdateData(profilePicture: downloadURL));
                  });
                }

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<PageBloc>(context)
                            .add(GoToProfilePage());
                      },
                      child: Container(
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
                          backgroundImage: Image(
                            image: (userState.user.profilePicture == '' ||
                                    userState.user.profilePicture == null)
                                ? const AssetImage('assets/images/user_pic.png')
                                    as ImageProvider
                                : NetworkImage(
                                    userState.user.profilePicture!,
                                  ),
                            fit: BoxFit.cover,
                          ).image,
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

        // section: NOW PLAYING
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Now Playing',
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              BlocProvider.of<MovieBloc>(context).add(const FetchMovies(1));

              if (movieState is MovieLoaded) {
                if (movieState.movies.isNotEmpty) {
                  List<Movie> movies = movieState.movies.sublist(0, 10);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        right: (movies[index] != movies.last) ? 16 : 0,
                      ),
                      child: MovieCard(
                        movies[index],
                        onTap: () {
                          BlocProvider.of<PageBloc>(context)
                              .add(GoToMovieDetailPage(movies[index]));
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No data found',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  );
                }
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),

        // section: BROWSE MOVIE
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Browse Movie',
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 68,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) {
                if (userState is UserLoaded) {
                  List<String> genres = userState.user.selectedGenre!;

                  List<Widget> widgets = List.generate(
                    genres.length,
                    (index) => BrowseButton(genres[index]),
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: widgets,
                  );
                } else {
                  return SpinKitFadingCircle(
                    size: 40,
                    color: mainColor,
                  );
                }
              },
            ),
          ),
        ),

        // section: COMING SOON
        Container(
          alignment: Alignment.centerLeft,
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 12),
          child: Text(
            'Coming Soon',
            style: blackTextFont.copyWith(fontSize: 16),
          ),
        ),
        SizedBox(
          height: 140,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (_, movieState) {
              BlocProvider.of<MovieBloc>(context).add(const FetchMovies(1));

              if (movieState is MovieLoaded) {
                if (movieState.movies.isNotEmpty) {
                  List<Movie> movies = movieState.movies.sublist(10);

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    itemBuilder: (_, index) => Container(
                      margin: EdgeInsets.only(
                        right: (movies[index] != movies.last) ? 16 : 0,
                      ),
                      child: ComingSoonCard(movies[index]),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No data found',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                  );
                }
              } else {
                return SpinKitFadingCircle(
                  color: mainColor,
                  size: 50,
                );
              }
            },
          ),
        ),

        // section: PROMO
        Container(
          margin:
              const EdgeInsets.fromLTRB(defaultMargin, 30, defaultMargin, 138),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Get Lucky Day',
                  style: blackTextFont.copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 13),
              Column(
                children: List.generate(
                  dummyPromos.length,
                  (index) => Container(
                    margin: EdgeInsets.only(
                      bottom: (index != (dummyPromos.length - 1)) ? 16 : 0,
                    ),
                    child: PromoCard(dummyPromos[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
