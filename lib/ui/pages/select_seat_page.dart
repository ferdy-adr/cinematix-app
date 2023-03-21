part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  const SelectSeatPage(this.ticket, {super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToSelectSchedulePage(widget.ticket.movieDetail));

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
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<PageBloc>(context).add(
                                          GoToSelectSchedulePage(
                                              widget.ticket.movieDetail));
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    child: Text(
                                      widget.ticket.movieDetail.title,
                                      maxLines: 2,
                                      textAlign: TextAlign.right,
                                      style: blackTextFont.copyWith(
                                        fontSize: 20,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                        loadingBuilder:
                                            (_, child, loadingProgress) {
                                          if (loadingProgress
                                                  ?.cumulativeBytesLoaded ==
                                              loadingProgress
                                                  ?.expectedTotalBytes) {
                                            return child;
                                          } else {
                                            return SpinKitFadingCircle(
                                              color: mainColor,
                                              size: 30,
                                            );
                                          }
                                        },
                                        image: NetworkImage(
                                            '$imageBaseURL/w300/${widget.ticket.movieDetail.posterPath}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
