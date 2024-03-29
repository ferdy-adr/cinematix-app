part of 'pages.dart';

class TicketDetailPage extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailPage(this.ticket, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToTicketPage(
            isExpiredTickets: ticket.time.isBefore(DateTime.now())));

        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor2,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 22),
                  child: Column(
                    children: [
                      // section: HEADER
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Ticket Details',
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context).add(
                                    GoToTicketPage(
                                        isExpiredTickets: ticket.time
                                            .isBefore(DateTime.now())));
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // section: TICKET DETAILS
                      Container(
                        width: MediaQuery.of(context).size.width -
                            (2 * defaultMargin),
                        padding: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: whitebackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image(
                                height: 170,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '$imageBaseURL/w500${ticket.movieDetail.backdropPath}'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.movieDetail.title,
                                    style: blackTextFont.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    ticket.movieDetail.genresAndLanguage,
                                    style: greyTextFont.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  RatingStars(
                                      voteAverage:
                                          ticket.movieDetail.voteAverage,
                                      colorTheme: ColorTheme.darkTheme),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextRowItem('Cinema', ticket.theater.name),
                                  const SizedBox(height: 8),
                                  TextRowItem(
                                      'Date & Time', ticket.time.dateAndTime),
                                  const SizedBox(height: 8),
                                  TextRowItem(
                                      'Seat Number', ticket.seatsInString),
                                  const SizedBox(height: 8),
                                  TextRowItem('ID Order', ticket.bookingCode),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const DashLineDivider(
                              height: 2,
                              color: Color(0xFFE4E4E4),
                            ),
                            const SizedBox(height: 18),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          ticket.name,
                                          style: blackTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Paid',
                                          style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          NumberFormat.currency(
                                            locale: 'id_ID',
                                            decimalDigits: 0,
                                            symbol: 'Rp ',
                                          ).format(ticket.totalPrice),
                                          style: whiteNumberFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  QrImage(
                                    data: ticket.bookingCode,
                                    size: 100,
                                    version: QrVersions.auto,
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

class TicketDetailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, size.height * 0.75);
    // path.moveTo(x, y)

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
