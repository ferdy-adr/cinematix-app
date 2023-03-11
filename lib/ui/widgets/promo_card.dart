part of 'widgets.dart';

class PromoCard extends StatelessWidget {
  final Promo promo;

  const PromoCard(this.promo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [Colors.transparent, mainColor.withOpacity(0.08)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(const Rect.fromLTRB(0, 0, 77.5, 80));
            },
            blendMode: BlendMode.dstIn,
            child: const SizedBox(
              width: 77.5,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image(
                  image: AssetImage('assets/images/reflection2.png'),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [mainColor.withOpacity(0.1), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(const Rect.fromLTRB(0, 0, 108, 43));
              },
              blendMode: BlendMode.dstIn,
              child: const SizedBox(
                width: 108,
                height: 43,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/reflection1.png'),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [mainColor.withOpacity(0.1), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(const Rect.fromLTRB(0, 0, 68, 27));
              },
              blendMode: BlendMode.dstIn,
              child: const SizedBox(
                width: 68,
                height: 27,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/reflection1.png'),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promo.title,
                      style: whiteTextFont.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      promo.subtitle,
                      style: whiteTextFont.copyWith(
                        color: const Color(0xFFA99BE3),
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'OFF',
                      style: yellowNumberFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      ' ${promo.discount}%',
                      style: yellowNumberFont.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
