import 'package:bt_bili/util/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.title,
    required this.enable,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enable ? onPressed : null,
      color: primary,
      disabledColor: primary[50],
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Text(title, style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
