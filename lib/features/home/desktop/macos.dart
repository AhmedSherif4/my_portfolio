import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class HomeMacos extends StatelessWidget {
  const HomeMacos({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return MacosWindow(
      child: MacosScaffold(),
    );
  }
}
