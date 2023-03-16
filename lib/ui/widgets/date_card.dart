part of 'widgets.dart';

class DateCard extends StatelessWidget {
  final bool isSelected, isEnable;
  final double width, height;
  final DateTime date;
  final Function? onTap;

  const DateCard(this.date,
      {this.isSelected = false,
      this.isEnable = true,
      this.width = 70,
      this.height = 90,
      this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isEnable != true)
          ? null
          : (onTap == null)
              ? null
              : () {
                  onTap!();
                },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: (isEnable != true)
              ? const Color(0xFFF6F6F6)
              : (isSelected != true)
                  ? Colors.transparent
                  : accentColor2,
          border: Border.all(
            width: 1,
            color: (isEnable != true)
                ? const Color(0xFFF6F6F6)
                : (isSelected != true)
                    ? const Color(0xFFE4E4E4)
                    : accentColor2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.shortDayName,
              style: blackTextFont.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color:
                    (isEnable != true) ? const Color(0xFFDDDCDC) : Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              date.day.toString(),
              style: whiteNumberFont.copyWith(
                color:
                    (isEnable != true) ? const Color(0xFFDDDCDC) : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
