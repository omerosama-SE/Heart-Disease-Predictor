import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpFields extends StatelessWidget {
  SignUpFields(
      {required this.text,
      required this.controller,
      this.errorText,
      this.numFields,
      this.length,
      this.validator});

  final TextEditingController controller;

  @override
  final String text;
  String? errorText;
  int? length;
  TextInputType? numFields;
  String? Function(String?)? validator;
  FocusNode myFocusNode = FocusNode();
  Widget build(BuildContext context) {
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    );
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.08,
          width: width * 0.95,
          child: TextFormField(
              // focusNode: myFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              keyboardType: numFields,
              controller: controller,
              cursorColor: Color(0xff004670),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                labelText: '$text',
                border: borderStyle,
                focusedBorder: borderStyle,
                enabledBorder: borderStyle,
                errorText: errorText,
              )),
        ),
        SizedBox(
          height: height * 0.002,
        )
      ],
    );
  }
}
