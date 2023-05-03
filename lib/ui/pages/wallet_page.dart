part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent previouslyPageEvent;

  const WalletPage(this.previouslyPageEvent, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(previouslyPageEvent);
        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),

                  // note: section HEADER
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'My Walet',
                            style: blackTextFont.copyWith(fontSize: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<PageBloc>(context)
                                  .add(previouslyPageEvent);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // note: section WALLET CARD
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    width: double.infinity,
                    height: 185,
                    decoration: BoxDecoration(
                      color: const Color(0xFF382A74),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          spreadRadius: 0,
                          color: mainColor.withOpacity(0.3),
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: WalletCardClipper(),
                          child: Container(
                            width: double.infinity,
                            height: 185,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0),
                                  Colors.white.withOpacity(0.1)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) {
                              return Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 18,
                                        height: 18,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFF2CB),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: accentColor2,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id_ID',
                                            decimalDigits: 0,
                                            symbol: 'IDR ')
                                        .format((userState is UserLoaded)
                                            ? userState.user.balance
                                            : 0)
                                        .toString(),
                                    style: whiteNumberFont.copyWith(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Card Holder',
                                            style: whiteTextFont.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                (userState is UserLoaded &&
                                                        userState.user.name !=
                                                            null)
                                                    ? (userState.user.name!
                                                                .length <=
                                                            34
                                                        ? userState.user.name!
                                                        : userState.user.name!
                                                            .substring(0, 33))
                                                    : 'No Name',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                width: 14,
                                                height: 14,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF3E9D9D),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 9.33,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 30),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Card ID',
                                            style: whiteTextFont.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                (userState is UserLoaded &&
                                                        userState.user.name !=
                                                            null)
                                                    ? userState.user.id
                                                        .substring(0, 10)
                                                        .toUpperCase()
                                                    : 'No ID',
                                                style: whiteTextFont.copyWith(
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Container(
                                                width: 14,
                                                height: 14,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF3E9D9D),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 9.33,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // note: section RECENT TRANSACTION
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Transactions',
                        style: blackTextFont.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        return FutureBuilder(
                          future: UserTransactionServices.getTransaction(
                              (userState as UserLoaded).user.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultMargin),
                                child: Column(
                                  children: generateRecentTransaction(
                                    snapshot.data!,
                                    width: MediaQuery.of(context).size.width -
                                        (2 * defaultMargin),
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Transaction not found',
                                  style: blackTextFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: const Alignment(0, 0.9),
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<PageBloc>(context).add(
                        GoToTopUpPage(GoToWalletPage(previouslyPageEvent)));
                  },
                  backgroundColor: accentColor2,
                  child: Icon(
                    MdiIcons.walletPlus,
                    size: 26,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateRecentTransaction(List<UserTransaction> transactions,
      {required double width}) {
    List<UserTransaction> sortedTransactions = transactions;
    sortedTransactions.sort(
      (a, b) => b.time.compareTo(a.time),
    );

    return sortedTransactions
        .map((element) => Container(
              margin: EdgeInsets.only(
                  bottom: (sortedTransactions.indexOf(element) !=
                          sortedTransactions.length - 1)
                      ? 12
                      : 100),
              child: TransactionCard(element, width: width),
            ))
        .toList();
  }
}

class WalletCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
