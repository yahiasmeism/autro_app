import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  final WidgetBuilder mobile, desktop;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 900) {
      return desktop(context);
    } else if (screenWidth > 600) {
      return const Scaffold(
        body: Center(
          child: Text('No Support Device Screen'),
        ),
      );
    } else {
      return mobile(context);
    }

    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     if (constraints.maxWidth > 600) {
    //       return desktop(context);
    //     } else {
    //       return mobile(context);
    //     }
    //   },
    // );
  }
}
