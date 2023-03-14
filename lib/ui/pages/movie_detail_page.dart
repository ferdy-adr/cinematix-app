part of 'pages.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    MovieDetail movieDetail;
    List<Credit> credits;

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToMainPage());

        return false;
      },
      child: Scaffold(
        backgroundColor: accentColor1,
        body: SafeArea(
          child: FutureBuilder(
            future: MovieServices.getDetails(movie),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                movieDetail = snapshot.data!;
                return Container(
                  color: whitebackgroundColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // section: BACKDROP IMAGE
                              SizedBox(
                                height: 270,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '$imageBaseURL/original${movieDetail.backdropPath}'),
                                ),
                              ),

                              // section: TITLE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    Text(
                                      movieDetail.title,
                                      textAlign: TextAlign.center,
                                      style:
                                          blackTextFont.copyWith(fontSize: 24),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      movieDetail.genresAndLanguage,
                                      textAlign: TextAlign.center,
                                      style:
                                          greyTextFont.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RatingStars(
                                          voteAverage: movieDetail.voteAverage,
                                          colorTheme: ColorTheme.darkTheme,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),

                              // section: CAST & CREW
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cast & Crew',
                                    style: blackTextFont.copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 110,
                                child: FutureBuilder(
                                  future:
                                      MovieServices.getCredits(movieDetail.id),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      credits = snapshot.data!;

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: defaultMargin),
                                        itemCount: credits.length,
                                        itemBuilder: (_, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                right: (index !=
                                                        credits.length - 1)
                                                    ? 12
                                                    : 0),
                                            child: CastCrewCard(credits[index]),
                                          );
                                        },
                                      );
                                    } else {
                                      return SpinKitFadingCircle(
                                        color: mainColor,
                                        size: 40,
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  color: whitebackgroundColor,
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: mainColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
