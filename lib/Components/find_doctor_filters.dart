import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FindDoctorsFilters extends StatefulWidget {
  FindDoctorsFilters(
      {required this.text,
      required this.onTap,
      required this.textColor,
      required this.backgroundColor});

  String text;
  void Function()? onTap;
  Color textColor;
  Color backgroundColor;
  @override
  State<FindDoctorsFilters> createState() => _FindDoctorsFiltersState();
}

class _FindDoctorsFiltersState extends State<FindDoctorsFilters> {
  int upcoming = 1;
  int compeleted = 0;
  int cancelled = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.284,
          height: MediaQuery.of(context).size.width * 0.1,
          child: ElevatedButton(
              onPressed: widget.onTap,
              child: Text('${widget.text}',
                  style: TextStyle(
                      color: widget.textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26),
                    borderRadius: BorderRadius.circular(7)),
                backgroundColor: widget.backgroundColor,
              )),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.024),
      ],
    );
  }
}
