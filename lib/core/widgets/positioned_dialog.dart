import 'package:flutter/material.dart';

class PositionedDialog {
  final BuildContext context;
  final GlobalKey globalKey;
  final Widget Function(BuildContext) builder;
  final double? height;
  OverlayEntry? _overlayEntry;

  PositionedDialog({
    required this.context,
    required this.globalKey,
    required this.builder,
    this.height,
  });

  void show() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height + 8,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: size.width,
                  height: height ?? 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: builder(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
