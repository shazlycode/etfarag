import 'package:etfarag/desktop_screens/desktop_body.dart';
import 'package:etfarag/mobile_screens/mobile_body.dart';
import 'package:etfarag/responsive/responsive_layout.dart';
import 'package:etfarag/tab_screens/tab_body.dart';
import 'package:flutter/material.dart';

import 'add_movie_screen.dart';

class MainScree extends StatefulWidget {
  const MainScree({Key? key}) : super(key: key);

  @override
  State<MainScree> createState() => _MainScreeState();
}

class _MainScreeState extends State<MainScree> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobileBody: MobileBody(),
      desktopBody: DesktopBody(),
      tabBody: TabBody(),
    );
  }
}
