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
                                  loadingBuilder: (_, child, loadingProgress) {
                                    if (loadingProgress
                                            ?.cumulativeBytesLoaded ==
                                        loadingProgress?.expectedTotalBytes) {
                                      return Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          child,
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 70.2,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.transparent
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16,
                                                horizontal: defaultMargin),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    BlocProvider.of<PageBloc>(
                                                            context)
                                                        .add(GoToMainPage()),
                                                child: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return SpinKitFadingCircle(
                                          color: mainColor);
                                    }
                                  },
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

                              // section: STORYLINE
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Storyline',
                                        style: blackTextFont.copyWith(
                                            fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movieDetail.overview,
                                      style: greyTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        height: 1.428,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),

                              // section: BUTTON
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 55),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 46,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<PageBloc>(context)
                                                .add(GoToSelectSchedulePage(
                                                    movieDetail));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Continue to Book',
                                            style: whiteTextFont.copyWith(
                                              fontSize: 16,
                                              height: 1.375,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
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
