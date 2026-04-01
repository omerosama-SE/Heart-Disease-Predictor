import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/screens/Sign_Up.dart';
import 'package:heart_disease_prediction/screens/login_page.dart';
import 'package:heart_disease_prediction/screens/login_page_updated.dart';
import 'package:heart_disease_prediction/screens/login_page_v3.dart';
import 'package:heart_disease_prediction/screens/sign_up_page_updated.dart';
import 'dart:math' as math;

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD7E8F0),
      body: Column(
        children: [
          Image.asset(
              'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
          Text(
            'Heart Disease',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xff004670)),
          ),
          Text(
            'Prediction',
            style: TextStyle(
                fontFamily: 'Myriad',
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color(0xff004670)),
          ),

          // Text(
          //   'Predictor',
          //   style: TextStyle(
          //       fontFamily: 'Myriad',
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold,
          //       color: Color(0xff004670)),
          // ),
          // SizedBox(height: 100),
          // Spacer(flex: 1),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Register();
                    }));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      backgroundColor: Color(0xff00466B),
                      fixedSize: Size(140, 50))),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPageUpdated();
                    }));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Color(0xff00466B), fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      backgroundColor: Color(0xffD7E8F0),
                      fixedSize: Size(140, 50),
                      side: BorderSide(color: Color(0xff00466B)))),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}

class PulseAnimation extends StatefulWidget {
  @override
  _PulseAnimationState createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -10 * (controller.value - 0.5).abs() + 5),
          child: child,
        );
      },
      child: Image.asset(
          'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'), // replace with your logo asset
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class BouncingLogo extends StatefulWidget {
  BouncingLogo({required this.height});

  double height;
  @override
  _BouncingLogoState createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<BouncingLogo>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: SizedBox(
        height: widget.height,
        child: Image.asset(
            'assets/images/_31f75d3e-ef0d-4330-adca-3e9f76cdae2a-removebg.png'),
      ), // replace with your logo asset
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//logo name

// class GradientText extends StatelessWidget {
//   final String text;
//   GradientText(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       shaderCallback: (bounds) => LinearGradient(
//         colors: [Colors.red, Colors.blue],
//         tileMode: TileMode.mirror,
//       ).createShader(bounds),
//       child: Text(
//         text,
//         style: TextStyle(
//             fontSize: 45,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontFamily: 'Myriad'),
//       ),
//     );
//   }
// }

