part of 'package:app1/constants.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color colorForHintText = Color(0x2A000000);
  static const Color backGroundColor = Color(0xFFEEEEEE);
  static const Color green = Color(0xFF10F00C); //0xFF10F00C
  static const Color turquoise  = Color(0xff21e9ce); //0xFF10F00C
  static const Color red = Color(0xFFfc0f2b); //0xFFFF000D
  static const Color dark = Color(0xff2D2D2D);
  static const Color grey = Color(0x8f2D2D2D);
  static const Color black = Color(0xff000000);
  static const Color colorForProtein = Color(0xffFFDE00);
  static const Color colorForFats = Color(0xffFF599E);
  static const Color colorForCarbohydrates = Color(0xffBF4DF5);
  static const LinearGradient greenGradient = LinearGradient(
      colors: [
        Color(0xff21e9ce),
        Color(0xff01c57c),
      ]
  );
}

@Deprecated('Не юзать!')
class ThemeColors extends ThemeExtension<ThemeColors>{

  final Color color;

  ThemeColors(this.color);

  @override
  ThemeExtension<ThemeColors> copyWith({
    Color? filterButtonFillColor,
  }) {
    return ThemeColors(
      filterButtonFillColor ?? color,
    );
  }

  @override
  ThemeExtension<ThemeColors> lerp(
      ThemeExtension<ThemeColors>? other,
      double t,
      ) {
    if (other is! ThemeColors) {
      return this;
    }

    return ThemeColors(Color.lerp(color, other.color, t)!);
  }

  static ThemeExtension<ThemeColors> otherColor(Color color) {
    return ThemeColors(color);
  }
}
