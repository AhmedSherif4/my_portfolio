import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../web/web.dart';

class HomeMacos extends StatelessWidget {
  const HomeMacos({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //todo: try the package of macos widgets
    return HomeWeb();
  }
}
