import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protect;

  const LoginEffect({super.key, required this.protect});

  @override
  State<LoginEffect> createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage(
              widget.protect
                  ? "images/head_left_protect.png"
                  : "images/head_left.png",
            ),
            height: 90,
          ),
          Image(image: AssetImage("images/logo.png"), height: 50),
          Image(
            image: AssetImage(
              widget.protect
                  ? 'images/head_right_protect.png'
                  : 'images/head_right.png',
            ),
            height: 90,
          ),
        ],
      ),
    );
  }
}
