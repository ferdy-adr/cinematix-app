part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GoToProfilePage());
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
                      defaultMargin, 20, defaultMargin, 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Your\nProfile',
                                textAlign: TextAlign.center,
                                style: blackTextFont.copyWith(
                                  fontSize: 20,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PageBloc>(context)
                                      .add(GoToProfilePage());
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
