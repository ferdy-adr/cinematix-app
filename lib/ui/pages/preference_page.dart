part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;
  final List<String> genres = [
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
  ];
  final List<String> languages = [
    'Bahasa',
    'English',
    'Japanese',
    'Korean',
  ];

  PreferencePage(this.registrationData, {super.key});

  @override
  State<PreferencePage> createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenre = [];
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedGenre = widget.registrationData.selectedGenre;
    selectedLanguage = widget.registrationData.selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = '';
        BlocProvider.of<PageBloc>(context)
            .add(GoToSignUpPage(widget.registrationData));

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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 56,
                          child: GestureDetector(
                            onTap: () {
                              widget.registrationData.password = '';
                              BlocProvider.of<PageBloc>(context)
                                  .add(GoToSignUpPage(widget.registrationData));
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select Your\nFavorite Genre',
                          textAlign: TextAlign.start,
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: defaultMargin,
                        runSpacing: defaultMargin,
                        children: generateGenreBox(context),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Movie Language\nYou Prefer?',
                          textAlign: TextAlign.start,
                          style: blackTextFont.copyWith(
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: defaultMargin,
                        runSpacing: defaultMargin,
                        children: generateLanguageBox(context),
                      ),
                      const SizedBox(height: 30),
                      FloatingActionButton(
                        onPressed: (selectedGenre.isNotEmpty &&
                                selectedLanguage != null)
                            ? () {
                                widget.registrationData.selectedGenre =
                                    selectedGenre;
                                widget.registrationData.selectedLanguage =
                                    selectedLanguage!;

                                BlocProvider.of<PageBloc>(context).add(
                                    GoToAccountConfirmationPage(
                                        widget.registrationData));
                              }
                            : null,
                        elevation: 0,
                        backgroundColor: (selectedGenre.isNotEmpty &&
                                selectedLanguage != null)
                            ? mainColor
                            : const Color(0xFFE4E4E4),
                        child: Icon(
                          Icons.arrow_forward,
                          color: (selectedGenre.isNotEmpty &&
                                  selectedLanguage != null)
                              ? Colors.white
                              : const Color(0xFFBEBEBE),
                        ),
                      ),
                      const SizedBox(height: 44),
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

  List<Widget> generateGenreBox(context) {
    double boxWidth = (MediaQuery.of(context).size.width -
            (2 * defaultMargin) -
            defaultMargin) /
        2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: boxWidth,
              height: 60,
              isSelected: selectedGenre.contains(e),
              onTap: () {
                if (!selectedGenre.contains(e)) {
                  if (selectedGenre.length < 4) {
                    selectedGenre.add(e);

                    setState(() {});
                  } else {
                    Flushbar(
                      messageText: Text(
                        'Can only select maximum 4 genre',
                        style: whiteTextFont.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(seconds: 4),
                      backgroundColor: const Color(0xFFFF5C83),
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);

                    setState(() {});
                  }
                } else {
                  selectedGenre.remove(e);

                  setState(() {});
                }
              },
            ))
        .toList();
  }

  List<Widget> generateLanguageBox(context) {
    double boxWidth = (MediaQuery.of(context).size.width -
            (2 * defaultMargin) -
            defaultMargin) /
        2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: boxWidth,
              height: 60,
              isSelected: selectedLanguage == e,
              onTap: () {
                if (selectedLanguage == null) {
                  selectedLanguage = e;

                  setState(() {});
                } else {
                  if (selectedLanguage == e) {
                    selectedLanguage = null;

                    setState(() {});
                  } else {
                    Flushbar(
                      messageText: Text(
                        'Can only select 1 language',
                        style: whiteTextFont.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(seconds: 4),
                      backgroundColor: const Color(0xFFFF5C83),
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);

                    setState(() {});
                  }
                }
              },
            ))
        .toList();
  }
}
