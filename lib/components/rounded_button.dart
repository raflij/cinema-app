import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final int color;
  final Color textColor;
  final VoidCallback press;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
            onPressed: press,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(color)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 40), // Adjust the value as needed
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
