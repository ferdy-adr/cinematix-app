part of 'widgets.dart';

class MoneyCard extends StatelessWidget {
  final double width;
  final int amount;
  final String currency;
  final bool isSelected;
  final Function? onTap;

  const MoneyCard(
      {this.width = 90,
      this.currency = 'IDR',
      this.amount = 0,
      this.isSelected = false,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null)
          ? null
          : () {
              onTap!();
            },
      child: Container(
        padding: const EdgeInsets.fromLTRB(7, 10, 7, 10),
        width: width.toDouble(),
        decoration: BoxDecoration(
          color: (isSelected) ? accentColor2 : Colors.transparent,
          border: Border.all(
            color: (isSelected) ? accentColor2 : const Color(0xFFE4E4E4),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currency,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: greyTextFont.copyWith(
                color: (isSelected) ? Colors.black : const Color(0xFFC4C4C4),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: '')
                  .format(amount),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: whiteNumberFont.copyWith(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
