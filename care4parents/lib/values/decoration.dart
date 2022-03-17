part of 'values.dart';

class Decorations {
  static customBoxDecoration({
    double blurRadius = 4,
    Color color = AppColors.red,
  }) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(blurRadius: blurRadius, color: color),
      ],
    );
  }

  static const BoxDecoration primaryDecoration = BoxDecoration(
    color: AppColors.secondaryColor,
    borderRadius: const BorderRadius.only(
      topLeft: const Radius.circular(Sizes.RADIUS_30),
      topRight: const Radius.circular(Sizes.RADIUS_30),
    ),
  );
}
