part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  const MovieCard(this.movie, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null)
          ? null
          : () {
              onTap!();
            },
      child: Container(
        width: 210,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('$imageBaseURL/w500${movie.backdropPath}'),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.61)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  movie.title,
                  maxLines: 2,
                  style: whiteTextFont.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 2),
              RatingStars(voteAverage: movie.voteAverage),
            ],
          ),
        ),
      ),
    );
  }
}
