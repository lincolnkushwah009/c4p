part of values;

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline5.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.subtitle1.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteButton => _poppinsTextTheme.button.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyText2.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );
  static TextStyle get primartSubtitle1 => _poppinsTextTheme.subtitle1.copyWith(
        color: Colors.white,
        fontSize: Sizes.dimen_14.sp,
        wordSpacing: 0.25,
        letterSpacing: 0.25,
        height: 1.5,
      );

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        subtitle1: whiteSubtitle1,
        bodyText2: whiteBodyText2,
        button: _whiteButton,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get tabTitle => subtitle1.copyWith(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
      fontSize: Sizes.dimen_18.sp,
      wordSpacing: 0.25,
      letterSpacing: -1);
  TextStyle get tabUnselectedTitle => subtitle1.copyWith(
      color: AppColors.blackShade3,
      fontWeight: FontWeight.w400,
      fontSize: Sizes.dimen_18.sp,
      wordSpacing: 0.25,
      letterSpacing: -1);

  TextStyle get greySubtitle1 => subtitle1.copyWith(
        color: Colors.grey,
      );

  TextStyle get blueHeadline6 => headline6.copyWith(
        color: AppColors.primaryColor,
      );

  TextStyle get blueHeadline4 => subtitle1.copyWith(
    color: AppColors.red,
  );
  TextStyle get blueBodyText2 => bodyText2.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      );

  TextStyle get greyCaption => caption.copyWith(
        color: Colors.grey,
      );
  TextStyle get whiteTabText => bodyText2.copyWith(
        color: AppColors.white,
        fontSize: Sizes.dimen_8.sp,
        fontWeight: FontWeight.w600,
      );
}
