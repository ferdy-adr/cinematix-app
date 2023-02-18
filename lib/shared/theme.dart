part of 'shared.dart';

const double defaultMargin = 24;

Color whitebackgroundColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color whitebackgroundColor2 = const Color.fromRGBO(246, 247, 249, 1.0);

Color mainColor = const Color(0xFF503E9D);
Color accentColor1 = const Color(0xFF2C1F63);
Color accentColor2 = const Color(0xFFFBD460);
Color accentColor3 = const Color(0xFFADADAD);

TextStyle blackTextFont = const TextStyle(fontFamily: 'Raleway')
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = const TextStyle(fontFamily: 'Raleway')
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);
TextStyle purpleTextFont = const TextStyle(fontFamily: 'Raleway')
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);
TextStyle greyTextFont = const TextStyle(fontFamily: 'Raleway')
    .copyWith(color: accentColor3, fontWeight: FontWeight.w500);

TextStyle whiteNumberFont =
    const TextStyle(fontFamily: 'OpenSans').copyWith(color: Colors.white);
TextStyle yellowNumberFont =
    const TextStyle(fontFamily: 'OpenSans').copyWith(color: accentColor2);
