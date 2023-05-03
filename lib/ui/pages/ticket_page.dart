part of 'pages.dart';

class TicketPage extends StatefulWidget {
  final bool? isExpiredTickets;

  const TicketPage({this.isExpiredTickets = false, super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool isExpiredTickets = false;

  @override
  void initState() {
    super.initState();
    if (widget.isExpiredTickets == true) {
      isExpiredTickets = widget.isExpiredTickets!;
    }
  }

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
              child: BlocBuilder<TicketBloc, TicketState>(
                builder: (_, ticketState) {
                  return TicketViewer(
                    (isExpiredTickets)
                        ? ticketState.tickets
                            .where((element) =>
                                element.time.isBefore(DateTime.now()))
                            .toList()
                        : ticketState.tickets
                            .where((element) =>
                                !element.time.isBefore(DateTime.now()))
                            .toList(),
                  );
                },
              ),
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

class TicketViewer extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketViewer(this.tickets, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Ticket> sortedTickets = tickets;
    sortedTickets.sort((a, b) => a.time.compareTo(b.time));

    if (sortedTickets.isNotEmpty) {
      return ListView.builder(
        padding:
            const EdgeInsets.fromLTRB(defaultMargin, 130, defaultMargin, 112),
        itemCount: sortedTickets.length,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () {
            BlocProvider.of<PageBloc>(context)
                .add(GoToTicketDetailPage(sortedTickets[index]));
          },
          child: Container(
            height: 90,
            margin: EdgeInsetsDirectional.only(
                bottom: (index != sortedTickets.length - 1) ? 20 : 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 70,
                    child: Image(
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress != null &&
                            loadingProgress.cumulativeBytesLoaded !=
                                loadingProgress.expectedTotalBytes) {
                          return SpinKitFadingCircle(
                            color: mainColor,
                            size: 30,
                          );
                        } else {
                          return child;
                        }
                      },
                      image: NetworkImage(
                          '$imageBaseURL/w400${sortedTickets[index].movieDetail.posterPath}'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sortedTickets[index].movieDetail.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: blackTextFont.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sortedTickets[index].movieDetail.genresAndLanguage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sortedTickets[index].theater.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: greyTextFont.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
