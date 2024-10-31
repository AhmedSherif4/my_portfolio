import 'package:flutter/material.dart';

import '../web/web.dart';

class HomeWindows extends StatefulWidget {
  const HomeWindows({super.key});

  @override
  State<HomeWindows> createState() => _HomeWindowsState();
}

class _HomeWindowsState extends State<HomeWindows> {
  @override
  Widget build(BuildContext context) {
    //todo: try the package of windows widgets
    return HomeWeb();
  }
}
