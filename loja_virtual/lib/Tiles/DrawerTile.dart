import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pagecontroller;
  final int page;
  DrawerTile(this.icon, this.text, this.pagecontroller, this.page);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pagecontroller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(icon,
                  size: 32.0,
                  color: pagecontroller.page.round() == page
                      ? Colors.blue[900]
                      : Colors.black),
              SizedBox(
                width: 32.0,
              ),
              Text(text,
                  style: GoogleFonts.comfortaa(
                      fontSize: 16.0,
                      color: pagecontroller.page.round() == page
                          ? Colors.blue[900]
                          : Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
