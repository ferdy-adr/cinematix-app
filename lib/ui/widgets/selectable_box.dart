part of 'widgets.dart';

class SelectableBox extends StatelessWidget {
  final String text;
  final bool isSelected, isEnable;
  final double width, height;
  final Function? onTap;
  final TextStyle? textStyle;

  const SelectableBox(this.text,
      {this.isSelected = false,
      this.isEnable = true,
      this.width = 144,
      this.height = 60,
      this.onTap,
      this.textStyle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isEnable)
          ? () {
              if (onTap != null) {
                onTap!();
              }
            }
          : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: (!isEnable)
              ? const Color(0xFFF6F6F6)
              : (isSelected)
                  ? accentColor2
                  : Colors.transparent,
          border: Border.all(
            color: (!isEnable)
                ? const Color(0xFFF6F6F6)
                : (isSelected)
                    ? accentColor2
                    : const Color(0xFFE4E4E4),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: (textStyle ?? blackTextFont).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: (!isEnable)
                  ? const Color(0xFFDDDCDC)
                  : (textStyle?.color != null)
                      ? textStyle?.color
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
