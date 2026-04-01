import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileCards extends StatelessWidget {
  UserProfileCards({required this.txt1, required this.txt2});

  String txt1;
  String txt2;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 65,
      decoration: BoxDecoration(
          color: Color(0xffD7E8F0), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              txt1,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  txt2,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
