part of 'widgets.dart';

class TextRowItem extends StatelessWidget {
  final String item, value;
  final TextStyle? valueStyle;

  const TextRowItem(this.item, this.value, {this.valueStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          item,
          style: greyTextFont.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: (valueStyle != null)
                ? valueStyle
                : whiteNumberFont.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
          ),
        ),
      ],
    );
  }
}
