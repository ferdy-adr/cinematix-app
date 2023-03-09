part of 'widgets.dart';

class ComingSoonCard extends StatelessWidget {
  final Movie movie;
  final Function? onTap;

  const ComingSoonCard(this.movie, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null)
          ? null
          : () {
              onTap!();
            },
      child: Container(
        width: 100,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('${imageBaseURL}w500${movie.posterPath}'),
          ),
        ),
      ),
    );
  }
}
