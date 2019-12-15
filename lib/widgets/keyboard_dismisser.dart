import 'package:flutter/material.dart';

class KeyboardDismiss extends StatelessWidget {
  final context;
  final child;

  KeyboardDismiss({@required this.context, @required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        debugPrint('Focus Changed');
      },
      child: child,
    );
  }
}

Widget keyboardDismisser(BuildContext context, Widget child) {
  final gesture = GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
      debugPrint('Focus Changed');
    },
    child: child,
  );
  return gesture;
}
