import 'package:flutter/material.dart';

class ExpansionTileNoDivider extends StatelessWidget {
  final title;
  final leading;
  final children;
  final initiallyExpanded;

  ExpansionTileNoDivider({
    @required this.title,
    @required this.leading,
    @required this.children,
    @required this.initiallyExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          Theme.of(context).copyWith(dividerColor: Colors.white.withOpacity(0)),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        title: title,
        leading: leading,
        children: children,
      ),
    );
  }
}
