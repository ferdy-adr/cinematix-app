part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;

  const SelectSchedulePage(this.movieDetail, {super.key});

  @override
  State<SelectSchedulePage> createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates = [];
  DateTime? selectedDate;

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
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          ),
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
