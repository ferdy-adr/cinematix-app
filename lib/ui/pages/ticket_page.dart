part of 'pages.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor1,
      body: SafeArea(
        child: Stack(
          children: [
            // BODY
            Container(
              color: whitebackgroundColor2,
            ),

            // HEADER
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                height: 110,
                color: accentColor1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultMargin, 20, defaultMargin, 0),
                      child: Text(
                        'My Tickets',
                        style: whiteTextFont.copyWith(
                          fontSize: 20,
                          color: whitebackgroundColor2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: (!isExpiredTickets)
                                          ? accentColor2
                                          : Colors.transparent,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Newest',
                                  textAlign: TextAlign.center,
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (!isExpiredTickets)
                                        ? whitebackgroundColor2
                                        : const Color(0xFF6F678E),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpiredTickets = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: (isExpiredTickets)
                                          ? accentColor2
                                          : Colors.transparent,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Oldest',
                                  textAlign: TextAlign.center,
                                  style: whiteTextFont.copyWith(
                                    fontSize: 16,
                                    color: (isExpiredTickets)
                                        ? whitebackgroundColor2
                                        : const Color(0xFF6F678E),
                                  ),
                                ),
                              ),
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
    );
  }
}
