part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket? ticket;
  final UserTransaction transaction;

  const SuccessPage(this.ticket, this.transaction, {super.key});

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
          child: FutureBuilder(
            future: (ticket != null)
                ? processingTicketOrder(context)
                : processingTopUp(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 86),
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage((ticket != null)
                                    ? 'assets/images/ticket_done.png'
                                    : 'assets/images/top_up_done.png'),
                              ),
                            ),
                            const SizedBox(height: 70),
                            Text(
                              (ticket != null)
                                  ? 'Happy Watching!'
                                  : 'Emmm Yummy!',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: blackTextFont.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              (ticket != null)
                                  ? 'You have successfully\nbought the ticket'
                                  : 'You have successfully\ntop up the wallet',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: greyTextFont.copyWith(
                                fontSize: 16,
                                height: 1.375,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 70),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width - (2 * 55),
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (ticket != null) {
                                    // view My Tickets
                                    BlocProvider.of<PageBloc>(context)
                                        .add(const GoToTicketPage());
                                  } else {
                                    // view My Wallet
                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToWalletPage(GoToMainPage()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  (ticket != null) ? 'My Tickets' : 'My Wallet',
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    height: 1.375,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Discover new movie?',
                                  overflow: TextOverflow.clip,
                                  style: greyTextFont.copyWith(
                                    fontSize: 14,
                                    height: 1.57,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToMainPage());
                                  },
                                  child: Text(
                                    ' Back to Home',
                                    overflow: TextOverflow.clip,
                                    style: purpleTextFont.copyWith(
                                      fontSize: 14,
                                      height: 1.57,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return SpinKitFadingCircle(
                  size: 50,
                  color: mainColor,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(Purchase(ticket!.totalPrice!));
    BlocProvider.of<TicketBloc>(context)
        .add(BuyTicket(transaction.userID, ticket!));
    await UserTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    BlocProvider.of<UserBloc>(context).add(TopUp(transaction.amount));
    await UserTransactionServices.saveTransaction(transaction);
  }
}
