import 'package:flutter/material.dart';

import '../components/app_bar.dart';

class HomeAndroid extends StatelessWidget {
  const HomeAndroid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomAppBarWidget(),
          ],
        ),
      ),
    );
  }
}
