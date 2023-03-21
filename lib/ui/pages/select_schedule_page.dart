part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  const SelectSchedulePage(this.movieDetail, {super.key});

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates = [];
  DateTime selectedDate = DateTime.now();
  int? selectedTime;
  Theater? selectedTheater;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    dates.addAll(
        List.generate(7, (index) => DateTime.now().add(Duration(days: index))));
    if (dates.isNotEmpty) {
      selectedDate = dates[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context)
            .add(GoToMovieDetailPage(widget.movieDetail));

        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 36),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<PageBloc>(context)
                                .add(GoToMovieDetailPage(widget.movieDetail));
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // section: CHOOSE DATE
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultMargin),
                        child: Text(
                          'Choose Date',
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultMargin),
                          itemCount: dates.length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(
                                right: (index != dates.length - 1) ? 16 : 0),
                            child: DateCard(
                              dates[index],
                              isSelected:
                                  (dates[index] == selectedDate) ? true : false,
                              onTap: () {
                                setState(() {
                                  selectedTheater = null;
                                  selectedTime = null;
                                  selectedDate = dates[index];
                                  isValid = (selectedTheater != null &&
                                          selectedTime != null)
                                      ? true
                                      : false;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // section: CHOOSE TIME
                      generateTimeTable(),

                      const SizedBox(height: 30),

                      // section: BUTTON
                      Center(
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (_, userState) {
                            return FloatingActionButton(
                              onPressed: (!isValid)
                                  ? null
                                  : () {
                                      BlocProvider.of<PageBloc>(context)
                                          .add(GoToSelectSeatPage(
                                        Ticket(
                                          widget.movieDetail,
                                          bookingCode: '000000000',
                                          name: (userState is UserLoaded &&
                                                  userState.user.name != null)
                                              ? userState.user.name!
                                              : 'null',
                                          theater: selectedTheater!,
                                          time: DateTime(
                                              selectedDate.year,
                                              selectedDate.month,
                                              selectedDate.day,
                                              selectedTime!),
                                        ),
                                      ));
                                    },
                              elevation: 0,
                              backgroundColor: (isValid)
                                  ? mainColor
                                  : const Color(0xFFE4E4E4),
                              child: Icon(
                                Icons.arrow_forward,
                                color: (isValid)
                                    ? Colors.white
                                    : const Color(0xFFBEBEBE),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 41),
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

  Column generateTimeTable() {
    List<int> times = List.generate(7, (index) => 10 + index * 2);
    List<Widget> widgets = [];

    for (var theater in dummyTheater) {
      widgets.add(
        Padding(
          padding:
              const EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child: Text(
            theater.name,
            style: blackTextFont.copyWith(fontSize: 20, height: 1.4),
          ),
        ),
      );

      widgets.add(
        SizedBox(
          height: 50,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            scrollDirection: Axis.horizontal,
            itemCount: times.length,
            itemBuilder: (_, index) => Container(
              margin:
                  EdgeInsets.only(right: (index != times.length - 1) ? 16 : 0),
              child: SelectableBox(
                '${times[index]}:00',
                width: 90,
                height: 50,
                isEnable: (times[index] > DateTime.now().hour ||
                        selectedDate.day > DateTime.now().day)
                    ? true
                    : false,
                isSelected:
                    (times[index] == selectedTime && theater == selectedTheater)
                        ? true
                        : false,
                onTap: () {
                  setState(() {
                    selectedTheater = theater;
                    selectedTime = times[index];
                    isValid = (selectedTheater != null && selectedTime != null)
                        ? true
                        : false;
                  });
                },
              ),
            ),
          ),
        ),
      );

      if (theater != dummyTheater.last) {
        widgets.add(
          const SizedBox(height: 20),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
