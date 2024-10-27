// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String word1;
  final String word2;
  const CustomAppBar({
    Key? key,
    required this.word1,
    required this.word2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: word1,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black)),
        TextSpan(
            text: word2, style: TextStyle(color: Colors.orange, fontSize: 19))
      ])),
    );
  }
}
