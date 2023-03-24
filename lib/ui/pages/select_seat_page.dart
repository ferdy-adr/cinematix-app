part of 'pages.dart';

class SelectSeatPage extends StatefulWidget {
  final Ticket ticket;

  const SelectSeatPage(this.ticket, {super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  // Already booked seats
  List<String> bookedSeats = [];

  @override
  void initState() {
    super.initState();

    if (widget.ticket.seats != null) {
      selectedSeats = widget.ticket.seats!;
    } else {
      selectedSeats.clear();
    }
  }

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

                      const SizedBox(height: 30),

                      // section: CINEMA SCREEN
                      const Center(
                        child: SizedBox(
                          width: 277,
                          child: Image(
                            image: AssetImage('assets/images/screen.png'),
                          ),
                        ),
                      ),

                      // section: SEATS
                      generateSeats(),
                      const SizedBox(height: 23),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SeatIndicator(
                            'Available',
                            colorCode: 0xFFE4E4E4,
                            fillColor: false,
                          ),
                          SizedBox(width: 20),
                          SeatIndicator(
                            'Booked',
                            colorCode: 0xFFF6F6F6,
                            fillColor: true,
                          ),
                          SizedBox(width: 20),
                          SeatIndicator(
                            'Selected',
                            colorCode: 0xFFFBD460,
                            fillColor: true,
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // section: BUTTON
                      Center(
                        child: FloatingActionButton(
                          onPressed: (selectedSeats.isEmpty)
                              ? null
                              : () {
                                  BlocProvider.of<PageBloc>(context).add(
                                      GoToCheckoutPage(widget.ticket
                                          .copyWith(seats: selectedSeats)));
                                },
                          elevation: 0,
                          backgroundColor: (selectedSeats.isNotEmpty)
                              ? mainColor
                              : const Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: (selectedSeats.isNotEmpty)
                                ? Colors.white
                                : const Color(0xFFBEBEBE),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
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

  Column generateSeats() {
    List<int> numberOfSeats = [3, 5, 5, 5, 5];
    List<Widget> widgets = [];

    for (int i = 0; i < numberOfSeats.length; i++) {
      widgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          numberOfSeats[i],
          (index) => Container(
            margin:
                EdgeInsets.only(right: (index < numberOfSeats[i] - 1) ? 16 : 0),
            child: SelectableBox(
              ('${String.fromCharCode(65 + i)}${index + 1}'),
              textStyle: whiteNumberFont.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              width: 40,
              height: 40,
              isSelected: selectedSeats
                  .contains('${String.fromCharCode(65 + i)}${index + 1}'),
              onTap: () {
                String seatNumber =
                    '${String.fromCharCode(65 + i)}${index + 1}';
                if (selectedSeats.contains(seatNumber)) {
                  setState(() {
                    selectedSeats.remove(seatNumber);
                  });
                } else {
                  setState(() {
                    selectedSeats.add(seatNumber);
                  });
                }
              },
              isEnable: !bookedSeats
                  .contains('${String.fromCharCode(65 + i)}${index + 1}'),
            ),
          ),
        ),
      ));

      widgets.add(SizedBox(height: (i < numberOfSeats.length - 1) ? 16 : 0));
    }

    return Column(
      children: widgets,
    );
  }
}

class SeatIndicator extends StatelessWidget {
  final String name;
  final int colorCode;

  /// Returns `true` if you want box body has filled with color.
  final bool fillColor;

  const SeatIndicator(this.name,
      {required this.colorCode, required this.fillColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: (fillColor == true) ? Color(colorCode) : Colors.transparent,
            border: Border.all(
              color: Color(colorCode),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          name,
          style: greyTextFont.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
