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
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 45),
            child: Column(
              children: [
                Stack(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
