part of 'widgets.dart';

class BrowseButton extends StatelessWidget {
  final String genre;

  const BrowseButton(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEFF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              (genre == 'Horror')
                  ? 'assets/images/ic_horror.png'
                  : (genre == 'Music')
                      ? 'assets/images/ic_music.png'
                      : (genre == 'Action')
                          ? 'assets/images/ic_action.png'
                          : (genre == 'Drama')
                              ? 'assets/images/ic_drama.png'
                              : (genre == 'War')
                                  ? 'assets/images/ic_war.png'
                                  : 'assets/images/ic_crime.png',
            ),
          ),
        ),
        Text(
          genre,
          style: blackTextFont.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
