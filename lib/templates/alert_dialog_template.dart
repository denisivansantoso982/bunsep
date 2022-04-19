import 'package:bunsep/templates/text_style_template.dart';
import 'package:flutter/material.dart';

class AlertDialogTemplate {

  static void showTheDialog({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyleTemplate.mediumDark(size: 18),
        ),
        content: Text(
          content,
          style: TextStyleTemplate.regularDark(size: 16),
        ),
        actions: actions,
      ),
    );
  }
}