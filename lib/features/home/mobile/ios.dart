import 'package:flutter/cupertino.dart';

class HomeIOS extends StatefulWidget {
  const HomeIOS({super.key});

  @override
  State<HomeIOS> createState() => _HomeIOSState();
}

class _HomeIOSState extends State<HomeIOS> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //todo : try the package of ios widgets
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Text('Iphon'),
      ),
    );
  }
}
