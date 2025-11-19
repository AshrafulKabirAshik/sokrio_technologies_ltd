import 'package:flutter/material.dart';

class WidgetSnackBar {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
  }) {
    // Close any existing snackbar
    ScaffoldMessenger.of(Navigator.of(context, rootNavigator: true).context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      duration: duration,
      backgroundColor: backgroundColor,
      /*behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(AppValues.contentPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppValues.childCornerRadius),
      ),*/
      elevation: 6,

      // smooth animation
      animation: CurvedAnimation(parent: kAlwaysCompleteAnimation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic),

      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(icon, color: textColor),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(message, style: TextStyle(color: textColor, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );

    // ✅ Show over bottomsheet
    ScaffoldMessenger.of(Navigator.of(context, rootNavigator: true).context).showSnackBar(snackBar);
  }
}
