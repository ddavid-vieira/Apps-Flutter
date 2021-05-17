import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viewhomework/Screens/TodayActivitie.dart';
import 'package:viewhomework/Screens/UnsuccessfulActvitie.dart';
import 'package:viewhomework/Screens/WeekActivitie.dart';

// ignore: must_be_immutable
class Tabs extends StatelessWidget {
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 0, 100, 0),
          title: Text('Tarefas',
              style: GoogleFonts.nunito(
                  fontSize: 24, fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorColor: Colors.black45,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 4,
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16.0)),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('${now.day}/' + '${now.month}',
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      icon: Icon(MaterialIcons.today),
                    ),
                    Tab(
                      icon: Icon(Ionicons.ios_calendar),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Semana',
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                    Tab(
                      icon: Icon(FontAwesome.remove),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Vencidas',
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 100, 0),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
              ),
              Expanded(
                flex: 3,
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Today(),
                    Week(),
                    Unsuccessful(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
