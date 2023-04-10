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
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
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

                      // section: ACCOUNT BALANCE and BUTTON
                      BlocBuilder<UserBloc, UserState>(
                        builder: (_, userState) {
                          if (userState is UserLoaded) {
                            if (userState.user.balance == null ||
                                userState.user.balance! <= totalPrice) {
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                () => Flushbar(
                                  flushbarPosition: FlushbarPosition.TOP,
                                  backgroundColor: const Color(0xFFFF5C83),
                                  duration: const Duration(seconds: 4),
                                  messageText: Text(
                                    'You need to top up your wallet first',
                                    textAlign: TextAlign.center,
                                    style: whiteTextFont.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ).show(context),
                              );
                            }
                          }

                          return Column(
                            children: [
                              TextRowItem(
                                'Your Wallet',
                                NumberFormat.currency(
                                        locale: 'id_ID',
                                        decimalDigits: 0,
                                        symbol: 'Rp ')
                                    .format((userState is UserLoaded)
                                        ? userState.user.balance
                                        : 0),
                                valueStyle: whiteNumberFont.copyWith(
                                  color: (userState is! UserLoaded)
                                      ? null
                                      : (userState.user.balance != null &&
                                              userState.user.balance! >=
                                                  totalPrice)
                                          ? const Color(0xFF3E9D9D)
                                          : const Color(0xFFFF5C83),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 36),
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (2 * (defaultMargin + 31)),
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: (userState is! UserLoaded)
                                      ? null
                                      : () {
                                          if (userState.user.balance != null &&
                                              userState.user.balance! >=
                                                  totalPrice) {
                                            // If balance enough
                                            BlocProvider.of<PageBloc>(context)
                                                .add(GoToSuccessPage(
                                              widget.ticket.copyWith(
                                                  totalPrice: totalPrice),
                                              UserTransaction(
                                                userID: userState.user.id,
                                                title: widget
                                                    .ticket.movieDetail.title,
                                                subtitle:
                                                    widget.ticket.theater.name,
                                                time: DateTime.now(),
                                                amount: -totalPrice,
                                                picture: widget.ticket
                                                    .movieDetail.posterPath,
                                              ),
                                            ));
                                          } else {
                                            // If balance not enough
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: (userState is! UserLoaded)
                                        ? null
                                        : (userState.user.balance != null &&
                                                userState.user.balance! >=
                                                    totalPrice)
                                            ? const Color(0xFF3E9D9D)
                                            : mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: Text(
                                    (userState is! UserLoaded)
                                        ? 'null'
                                        : (userState.user.balance != null &&
                                                userState.user.balance! >=
                                                    totalPrice)
                                            ? 'Checkout Now'
                                            : 'Top Up My Wallet',
                                    style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      height: 1.375,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 45),
                            ],
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
