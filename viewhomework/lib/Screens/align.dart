import 'package:flutter/material.dart';

class Align1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: MyClipper1(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.blueAccent,
            ),
          )),
    );
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint = Offset(size.width / 2, 0);
    var endPoint = Offset(size.width, size.height);
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
