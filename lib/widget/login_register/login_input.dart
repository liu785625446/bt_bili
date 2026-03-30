import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChange;
  final ValueChanged<bool>? onFocusChange;

  const LoginInput({
    super.key,
    required this.title,
    required this.hint,
    required this.onChange,
    this.obscureText = false,
    this.keyboardType,
    this.onFocusChange,
  });

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (widget.onFocusChange != null) {
        widget.onFocusChange!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              width: 100,
              child: Text(widget.title, style: TextStyle(fontSize: 18)),
            ),
            _input(),
          ],
        ),
        Divider(height: 1, thickness: 0.5),
      ],
    );
  }

  Widget _input() {
    return Expanded(
      child: TextField(
        obscureText: widget.obscureText,
        onChanged: widget.onChange,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 10, right: 20),
        ),
      ),
    );
  }
}
