part of 'pages.dart';

enum MainPageInitialPageView { moviePage, ticketPage }

class MainPage extends StatefulWidget {
  final MainPageInitialPageView? initialPageView;
  final bool? isExpiredTickets;

  const MainPage({this.initialPageView, this.isExpiredTickets, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex = 0;
  PageController pageController = PageController();
  bool isExpiredTickets = false;

  @override
  void initState() {
    super.initState();

    if (widget.initialPageView != null) {
      switch (widget.initialPageView) {
        case MainPageInitialPageView.moviePage:
          bottomNavBarIndex = 0;
          break;
        case MainPageInitialPageView.ticketPage:
          bottomNavBarIndex = 1;
          break;
        default:
          bottomNavBarIndex = 0;
      }
    } else {
      bottomNavBarIndex = 0;
    }

    pageController = PageController(initialPage: bottomNavBarIndex);

    if (widget.isExpiredTickets != null) {
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
            Container(
              color: whitebackgroundColor2,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    bottomNavBarIndex = value;
                    if (bottomNavBarIndex != 1) isExpiredTickets = false;
                  });
                },
                children: [
                  // Movie Page
                  const MoviePage(),

                  // Ticket Page
                  TicketPage(isExpiredTickets: isExpiredTickets),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: createCustomBottomNavBar(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.only(bottom: 42),
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<PageBloc>(context)
                        .add(GoToTopUpPage(GoToMainPage()));
                  },
                  elevation: 0,
                  backgroundColor: accentColor2,
                  child: Icon(
                    size: 26,
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClipPath createCustomBottomNavBar() {
    return ClipPath(
      clipper: BottomNavBarClipper(),
      child: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: bottomNavBarIndex,
          onTap: (value) {
            setState(() {
              bottomNavBarIndex = value;
              pageController.jumpToPage(value);
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color.fromRGBO(224, 224, 224, 1),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'New Movies',
              icon: Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Image(
                      image: AssetImage((bottomNavBarIndex == 0)
                          ? 'assets/images/ic_movie.png'
                          : 'assets/images/ic_movie_grey.png'),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
            BottomNavigationBarItem(
              label: 'My Tickets',
              icon: Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Image(
                      image: AssetImage((bottomNavBarIndex == 1)
                          ? 'assets/images/ic_tickets.png'
                          : 'assets/images/ic_tickets_grey.png'),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 30, 0);
    path.quadraticBezierTo(size.width / 2 - 30, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 30, 33, size.width / 2 + 30, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
