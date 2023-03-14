part of 'widgets.dart';

enum ColorTheme { lightTheme, darkTheme }

class RatingStars extends StatelessWidget {
  final double voteAverage, starSize, fontSize;
  final ColorTheme colorTheme;

  const RatingStars(
      {this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      this.colorTheme = ColorTheme.lightTheme,
      super.key});

  @override
  Widget build(BuildContext context) {
    int rating = voteAverage.round() ~/ 2;

    List<Widget> widgets = List.generate(5, (index) {
      if (colorTheme == ColorTheme.lightTheme) {
        return Icon(
          Icons.star_rate,
          size: starSize,
          color: (index < rating)
              ? const Color(0xFFFBD460)
              : Colors.white.withOpacity(0.4),
        );
      } else {
        return Icon(
          Icons.star_rate,
          size: starSize,
          color: (index < rating)
              ? const Color(0xFFFBD460)
              : const Color(0xFFC4C4C4).withOpacity(0.4),
        );
      }
    });

    return Row(
      children: [
        Row(
          children: widgets,
        ),
        const SizedBox(width: 3),
        Text(
          '$voteAverage/10',
          style: whiteNumberFont.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: accentColor3,
          ),
        ),
      ],
    );
  }
}
