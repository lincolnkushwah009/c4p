part of values;

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
        textTheme: GoogleFonts.poppinsTextTheme(_textTheme),
        iconTheme: IconThemeData(color: AppColors.white),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        // accentColor: colorScheme.primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        focusColor: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
        primarySwatch: Colors.grey,
        accentColor: AppColors.primaryColor,
        fontFamily: 'Poppins');
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFF6673),
    primaryVariant: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Colors.white,
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const _superBold = FontWeight.w900;
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _blackBodyText1 => _poppinsTextTheme.bodyText1.copyWith(
        fontSize: Sizes.TEXT_SIZE_16.sp,
        color: AppColors.primaryText,
        fontWeight: _regular,
        fontStyle: FontStyle.normal,
      );
  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.roboto(
      fontSize: Sizes.TEXT_SIZE_96,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_60,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_48,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_34.sp,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_24.sp,
      color: AppColors.primaryText,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_20.sp,
      color: AppColors.primaryText,
      fontWeight: _bold,
      fontStyle: FontStyle.normal,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_18.sp,
      color: AppColors.primaryText,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_14.sp,
      color: AppColors.primaryText,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: _blackBodyText1,
    bodyText2: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_14.sp,
      color: AppColors.primaryText,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    button: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_14.sp,
      color: AppColors.primaryText,
      fontStyle: FontStyle.normal,
      fontWeight: _medium,
    ),
    caption: GoogleFonts.poppins(
      fontSize: Sizes.TEXT_SIZE_12.sp,
      color: AppColors.white,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
  );
}
