import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationFields extends StatefulWidget {
  const VerificationFields({super.key});

  @override
  State<VerificationFields> createState() => _VerificationFieldsState();
}

class _VerificationFieldsState extends State<VerificationFields> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 27),
        SizedBox(
            height: 60,
            width: 60,
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)))),
            )),
        SizedBox(width: 5),
      ],
    );
  }
}
