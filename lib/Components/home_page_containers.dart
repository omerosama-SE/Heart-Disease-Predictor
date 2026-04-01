import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class HomeContainers extends StatelessWidget {
  HomeContainers({required this.text, required this.img, required this.onTap});
  @override
  String text;
  Image img;
  VoidCallback onTap;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), // More transparent shadow
              spreadRadius: 2, // Reduced spread radius
              blurRadius: 4, // Reduced blur radius
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: img,
            ),
            Spacer(flex: 1),
            Text(
              '$text',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Icon(Icons.chevron_right, size: 20),
            Spacer(flex: 2),
          ],
        ),
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 70),
        // ),
      ),
    );
  }
}
