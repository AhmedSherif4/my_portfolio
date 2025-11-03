import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Comming Soon',
            style: const AppTextStyle().titleSmall24w5,
          ),
        ),
      ),
    );
  }
}
