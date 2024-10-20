import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';


class HomeWindows extends StatefulWidget {
  const HomeWindows({super.key});

  @override
  State<HomeWindows> createState() => _HomeWindowsState();
}

class _HomeWindowsState extends State<HomeWindows> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Windows'));

  }
}
