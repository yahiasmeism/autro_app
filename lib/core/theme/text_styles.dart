import 'package:autro_app/core/theme/app_colors.dart';
import 'package:autro_app/core/theme/font_weight_helper.dart';
import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();
  // static TextStyle font24BlackBold = TextStyle(
  //   fontSize: 24.sp,
  //   fontWeight: FontWeightHelper.bold,
  //   color: Colors.black,
  // );

  //? Roboto
  static TextStyle font16Regular = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.secondary,
  );
  static TextStyle font18Regular = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font10Regular = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font24SemiBold = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.secondary,
  );
  static TextStyle font20Regular = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.secondary,
  );
  static TextStyle font18Medium = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font10SemiBold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.semiBold,
  );

  static TextStyle font20SemiBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.secondaryOpacity50,
  );

  static TextStyle font14Regular = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font16SemiBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.secondary,
  );

  static TextStyle font14SemiBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.secondary,
  );

  static TextStyle font28SemiBold = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font18Bold = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeightHelper.bold,
  );

  //? Montserrat
  static TextStyle montserratFont16Regular = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.regular,
    fontFamily: 'Montserrat',
  );
  static TextStyle montserratFont26Regular = const TextStyle(
    fontSize: 26,
    fontWeight: FontWeightHelper.regular,
    fontFamily: 'Montserrat',
  );
  static TextStyle montserratFont16Medium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.medium,
    fontFamily: 'Montserrat',
    color: AppColors.secondary,
  );

  //?inter
  static TextStyle interFont15Regular = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeightHelper.regular,
    // fontFamily: 'Inter',
    color: AppColors.softBlueGray,
  );
}
