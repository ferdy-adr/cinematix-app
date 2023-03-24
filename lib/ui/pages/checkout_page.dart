part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  const CheckoutPage(this.ticket, {super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToSelectSeatPage(widget.ticket));
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

                      // section: HEADER
                      SizedBox(
                        height: 60,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Checkout\nMovie',
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
                                      .add(GoToSelectSeatPage(widget.ticket));
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

                      const SizedBox(height: 20),

                      // section: MOVIE INFORMATION
                      SizedBox(
                        height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      '$imageBaseURL/w300/${widget.ticket.movieDetail.posterPath}'),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SizedBox(
                              width: MediaQuery.of(context).size.width -
                                  (2 * defaultMargin + 70 + 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.ticket.movieDetail.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                    style: blackTextFont.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    widget.ticket.movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(height: 6),
                                  RatingStars(
                                    voteAverage:
                                        widget.ticket.movieDetail.voteAverage,
                                    colorTheme: ColorTheme.darkTheme,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // section: BOOKING DETAILS
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
