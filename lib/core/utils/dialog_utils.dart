import 'package:autro_app/core/utils/nav_util.dart';
import 'package:flutter/material.dart';

class DialogUtil {
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? title,
    bool Function(DateTime)? selectableDayPredicate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 10),
      helpText: title,
      selectableDayPredicate: selectableDayPredicate,
    );
  }

  static Future<TimeOfDay?> showTimePickerDialog(BuildContext context, {String? title, TimeOfDay? initialTime}) {
    return showTimePicker(
      context: context,
      helpText: title,
      initialTime: initialTime ?? const TimeOfDay(hour: 0, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },
    );
  }

  // static Future<Duration?> showDurationPickerDialog(BuildContext context, {Duration? initialTime}) {
  //   return showDurationPicker(
  //     context: context,
  //     initialTime: initialTime ?? const Duration(minutes: 30),
  //   );
  // }

  static showSuccessSnackBar(BuildContext context, String message) {
    const backgroundColor = Color(0xffD1E8D5);
    const textColor = Color(0xff365A37);
    showSnackBar(
      context,
      message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      prefixIcon: const Icon(
        Icons.check_circle,
        color: textColor,
        size: 24,
      ),
    );
  }

  static showWarningSnackBar(BuildContext context, String message) {
    const backgroundColor = Color(0xffFFF3CD);
    const textColor = Color(0xff9F6000);
    showSnackBar(
      context,
      message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      prefixIcon: const Icon(
        Icons.warning_rounded,
        color: textColor,
        size: 24,
      ),
    );
  }

  static showErrorSnackBar(BuildContext context, String message) {
    const backgroundColor = Color(0xffF8D7DA);
    const textColor = Color(0xff842029);
    showSnackBar(
      context,
      message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      prefixIcon: const Icon(
        Icons.error,
        color: textColor,
        size: 24,
      ),
    );
  }

  static showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Widget? prefixIcon,
    IconData? icon,
    Duration duration = const Duration(seconds: 4),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double elevation = 0,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          width: MediaQuery.of(context).size.width > 600 ? 600 : null,
          behavior: behavior,
          duration: duration,
          elevation: elevation,
          backgroundColor: backgroundColor,
          content: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: prefixIcon,
                ),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  static Future<bool?> showAlertDialog(
    BuildContext context, {
    String? title,
    String? content,
    String? positiveText,
    Text? negativeText,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content ?? ''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(negativeText as String? ?? 'Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(positiveText ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    String? title,
    String? content,
    String? positiveText,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? 'Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content ?? ''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(positiveText ?? 'OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // static Future<String?> showtextInputDialog(
  //   BuildContext context, {
  //   required String hintText,
  //   bool isObscure = false,
  //   bool barrierDismissible = true,
  //   String? btnText,
  //   String? header,
  //   String? initialValue,
  //   int maxLines = 10,
  //   TextInputType? inputType,
  // }) {
  //   return showDialog<String?>(
  //     context: context,
  //     barrierDismissible: barrierDismissible,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: TextInputDialog(
  //           header: header,
  //           hintText: hintText,
  //           isObscure: isObscure,
  //           initialValue: initialValue,
  //           maxLines: maxLines,
  //           inputType: inputType,
  //           btnText: btnText,
  //         ),
  //       );
  //     },
  //   );
  // }

  // static Future<PickerDateRange?> showDateRangePicker(BuildContext context, DateTime? startDate, DateTime? endDate) {
  //   return showDialog<PickerDateRange>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: SizedBox(
  //           height: MediaQuery.of(context).size.height * 0.5,
  //           child: SfDateRangePicker(
  //             showActionButtons: true,
  //             selectionMode: DateRangePickerSelectionMode.extendableRange,
  //             initialSelectedRange: PickerDateRange(startDate, endDate),
  //             initialDisplayDate: startDate,
  //             onSubmit: (args) => Navigator.of(context).pop(args),
  //             onCancel: () => Navigator.of(context).pop(),
  //             confirmText: TransUtil.trans(ITMCoreStrings.btnOk),
  //             cancelText: TransUtil.trans(ITMCoreStrings.btnCancel),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Future<dynamic> showStandardDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    bool showCloseBtnWhenNotDismissible = true,
    double? height,
  }) {
    return showDialog<dynamic>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: SizedBox(
            height: height,
            // height: height ?? MediaQuery.of(context).size.height * 0.35,
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!barrierDismissible && showCloseBtnWhenNotDismissible)
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => NavUtil.pop(context),
                      ),
                    // Expanded(child: child),
                    child
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showBottomSheet(
    BuildContext context,
    Widget body, {
    double? minHeight,
    double? maxHeight,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    final maxHeightDefault = MediaQuery.of(context).size.height;
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      constraints: BoxConstraints(maxHeight: maxHeight ?? maxHeightDefault * 0.5, minHeight: minHeight ?? 100),
      // builder: (context) => BottomSheetWrapper(height: height, child: body),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          children: [
            body,
          ],
        ),
      ),
    );
  }

  static Future<dynamic> showBottomSheetExpanded(
    BuildContext context,
    Widget body, {
    double? minHeight,
    double? maxHeight,
    Color? bgColor,
    bool enableDrag = true,
    bool isDismissible = true,
  }) {
    final maxHeightDefault = MediaQuery.of(context).size.height;
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      showDragHandle: true,
      // backgroundColor: bgColor  ?? Theme.of(context).colorScheme.background,
      // backgroundColor: bgColor ?? ITMCoreColors.white,
      backgroundColor: Colors.white,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      constraints: BoxConstraints(maxHeight: maxHeight ?? maxHeightDefault * 0.5, minHeight: minHeight ?? 100),
      builder: (context) => body,
    );
  }
}
