part of 'widgets.dart';

class TransactionCard extends StatelessWidget {
  final UserTransaction transaction;
  final double width;

  const TransactionCard(this.transaction, {required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: (transaction.picture != null)
                    ? NetworkImage(
                        '$imageBaseURL/w300${transaction.picture}',
                      )
                    : const AssetImage('assets/images/bg_topup.png')
                        as ImageProvider),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: width - 86,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: blackTextFont.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 5),
              Text(
                NumberFormat.currency(
                  locale: 'id_ID',
                  decimalDigits: 0,
                  symbol: 'Rp. ',
                ).format((transaction.amount < 0)
                    ? -transaction.amount
                    : transaction.amount),
                style: whiteNumberFont.copyWith(
                  fontSize: 12,
                  color:
                      Color((transaction.amount < 0) ? 0xFFFF5C83 : 0xFF3E9D9D),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                transaction.subtitle,
                style: whiteNumberFont.copyWith(
                  fontSize: 12,
                  color: const Color(0xFFADADAD),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
