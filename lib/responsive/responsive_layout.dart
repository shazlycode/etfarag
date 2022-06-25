import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Responsive extends StatelessWidget {
  const Responsive({Key? key, this.mobileBody, this.tabBody, this.desktopBody})
      : super(key: key);
  final Widget? mobileBody;
  final Widget? tabBody;
  final Widget? desktopBody;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1000) {
        return desktopBody!;
      } else if (constraints.maxWidth >= 600 && constraints.maxWidth < 1000) {
        return tabBody!;
      } else {
        return mobileBody!;
      }
    });
  }
}
