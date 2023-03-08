part of 'widgets.dart';

class RatingStars extends StatelessWidget {
  final double voteAverage, starSize, fontSize;

  const RatingStars(
      {this.voteAverage = 0,
      this.starSize = 20,
      this.fontSize = 12,
      super.key});

  @override
  Widget build(BuildContext context) {
    int rating = voteAverage.round() ~/ 2;

    List<Widget> widgets = List.generate(
      5,
      (index) => Icon(
        Icons.star_rate,
        size: starSize,
        color: (index < rating)
            ? const Color(0xFFFBD460)
            : Colors.white.withOpacity(0.4),
      ),
    );

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
          ),
        ),
      ],
    );
  }
}
