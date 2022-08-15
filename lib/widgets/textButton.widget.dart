

// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';


class TextButtons extends StatelessWidget {
  final String name;
  final String route;
  final double width;
  final double fontSize;
  final String img;

  const TextButtons(
      {Key? key,
      required this.name,
      required this.route, required this.width, required this.fontSize, required this.img,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              Image(image: AssetImage('../assets/images/$img'),width: 80,),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize, color: const Color(0xff525252)),
              ),
            ],
          )),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffD9D9D9)),
      ),
    );
  }
}
