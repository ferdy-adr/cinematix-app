part of 'pages.dart';

class CheckoutPage extends StatefulWidget {
  final Ticket ticket;

  const CheckoutPage(this.ticket, {super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int ticketPrice = 25000;
  int ticketFee = 1500;
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = (ticketPrice + ticketFee) * widget.ticket.seats!.length;
  }

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
                      const Divider(
                        color: Color(0xFFE4E4E4),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          TextRowItem('ID Order', widget.ticket.bookingCode),
                          const SizedBox(height: 8),
                          TextRowItem('Cinema', widget.ticket.theater.name),
                          const SizedBox(height: 8),
                          TextRowItem(
                              'Date & Time', widget.ticket.time.dateAndTime),
                          const SizedBox(height: 8),
                          TextRowItem(
                              'Seat Number', widget.ticket.seatsInString),
                          const SizedBox(height: 8),
                          TextRowItem('Price',
                              '${NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "Rp ").format(ticketPrice)} x ${widget.ticket.seats!.length}'),
                          const SizedBox(height: 8),
                          TextRowItem('Fee',
                              '${NumberFormat.currency(locale: "id_ID", decimalDigits: 0, symbol: "Rp ").format(ticketFee)} x ${widget.ticket.seats!.length}'),
                          const SizedBox(height: 8),
                          TextRowItem(
                            'Total',
                            NumberFormat.currency(
                                    locale: "id_ID",
                                    decimalDigits: 0,
                                    symbol: "Rp ")
                                .format(totalPrice),
                            valueStyle: whiteNumberFont.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xFFE4E4E4),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
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

class TextRowItem extends StatelessWidget {
  final String item, value;
  final TextStyle? valueStyle;

  const TextRowItem(this.item, this.value, {this.valueStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item,
          style: greyTextFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: (valueStyle != null)
                ? valueStyle
                : whiteNumberFont.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
          ),
        ),
      ],
    );
  }
}
