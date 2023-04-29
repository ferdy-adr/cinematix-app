part of 'pages.dart';

class TopUpPage extends StatefulWidget {
  final PageEvent previouslyPageEvent;

  const TopUpPage(this.previouslyPageEvent, {super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController amountController = TextEditingController();

  List<int> topupAmountList = [
    50000,
    100000,
    150000,
    200000,
    250000,
    500000,
    1000000,
    2500000,
    5000000
  ];
  int amountValue = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(
        ThemeData(primarySwatch: const Color(0xFFE4E4E4).getMaterialColor())));

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ThemeBloc>(context).add(ChangeTheme(
            ThemeData(primarySwatch: accentColor2.getMaterialColor())));
        BlocProvider.of<PageBloc>(context).add(widget.previouslyPageEvent);
        return false;
      },
      child: Scaffold(
        backgroundColor: whitebackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                      defaultMargin, 20, defaultMargin, 45),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Top Up',
                                style: blackTextFont.copyWith(fontSize: 20),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<ThemeBloc>(context).add(
                                      ChangeTheme(ThemeData(
                                          primarySwatch: accentColor2
                                              .getMaterialColor())));
                                  BlocProvider.of<PageBloc>(context)
                                      .add(widget.previouslyPageEvent);
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
                      const SizedBox(height: 40),
                      TextField(
                        controller: amountController,
                        onChanged: (value) {
                          String temp = '';

                          for (int index = 0; index < value.length; index++) {
                            if (value.isDigit(index)) {
                              temp += value[index];
                            }
                          }

                          amountValue = int.tryParse(temp) ?? 0;

                          amountController.text = NumberFormat.currency(
                                  locale: 'id_ID',
                                  decimalDigits: 0,
                                  symbol: 'IDR ')
                              .format(amountValue);
                          amountController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: amountController.text.length));

                          setState(() {});
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          label: Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: Text(
                              'Amount',
                              style: greyTextFont.copyWith(
                                color: const Color(0xFFBEBEBE),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xFFE4E4E4),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Choose by Template',
                          style: blackTextFont.copyWith(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 21,
                        runSpacing: 14,
                        children: generateMoneyCard(context, topupAmountList),
                      ),
                      const SizedBox(height: 102),
                      (amountValue <= 0)
                          ? const SizedBox()
                          : (!isLoading)
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      (2 * (defaultMargin + 31)),
                                  height: 45,
                                  child: BlocBuilder<UserBloc, UserState>(
                                    builder: (_, userState) {
                                      return ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          UserTransaction? transaction =
                                              (userState is UserLoaded)
                                                  ? UserTransaction(
                                                      userID: userState.user.id,
                                                      title: 'Top Up Wallet',
                                                      subtitle:
                                                          '${DateTime.now().dayName}, ${DateTime.now().day} ${DateTime.now().monthName} ${DateTime.now().year}',
                                                      time: DateTime.now(),
                                                      amount: amountValue,
                                                    )
                                                  : null;

                                          setState(() {
                                            isLoading = false;
                                          });

                                          if (transaction != null) {
                                            BlocProvider.of<PageBloc>(context)
                                                .add(GoToSuccessPage(
                                                    null, transaction));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              const Color(0xFF3E9D9D),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Text(
                                          'Top Up Now',
                                          style: whiteTextFont.copyWith(
                                            fontSize: 16,
                                            height: 1.375,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : SpinKitFadingCircle(
                                  color: mainColor,
                                  size: 45,
                                ),
                      const SizedBox(height: 45),
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

  List<Widget> generateMoneyCard(BuildContext context, List<int> amountList) {
    double widgetWidth =
        (MediaQuery.of(context).size.width - (2 * defaultMargin) - 42) / 3;

    List<Widget> widgets = amountList
        .map((amount) => MoneyCard(
              amount: amount,
              width: widgetWidth,
              isSelected: amount == amountValue,
              onTap: () {
                setState(() {
                  if (amount != amountValue) {
                    amountValue = amount;
                  } else {
                    amountValue = 0;
                  }

                  amountController.text = NumberFormat.currency(
                          locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
                      .format(amountValue)
                      .toString();
                  amountController.selection = TextSelection.fromPosition(
                      TextPosition(offset: amountController.text.length));
                });
              },
            ))
        .toList();

    return widgets;
  }
}
