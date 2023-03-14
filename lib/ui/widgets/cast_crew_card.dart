part of 'widgets.dart';

class CastCrewCard extends StatelessWidget {
  final Credit credit;

  const CastCrewCard(this.credit, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: (credit.profilePath != null)
                  ? Colors.transparent
                  : Colors.grey[100],
            ),
            child: (credit.profilePath != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '$imageBaseURL/w400${credit.profilePath}'),
                    ),
                  )
                : const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
          ),
          Text(
            credit.name ?? 'Unknown',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: blackTextFont.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
