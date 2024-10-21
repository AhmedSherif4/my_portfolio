import 'package:flutter/material.dart';

import '../components/app_bar.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

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
