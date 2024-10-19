import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiTop extends StatefulWidget {
  final ConfettiController controller;
  const ConfettiTop({
    super.key,
    required this.controller,
  });

  @override
  State<ConfettiTop> createState() => _ConfettiTopState();
}

class _ConfettiTopState extends State<ConfettiTop> {
  @override
  dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: widget.controller,
        blastDirection: pi / 2,
        maxBlastForce: 5, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.05,
        numberOfParticles: 50, // a lot of particles at once
        gravity: 1,
      ),
    );
  }
}

class ConfettiBottom extends StatefulWidget {
  final ConfettiController controller;
  const ConfettiBottom({
    super.key,
    required this.controller,
  });

  @override
  State<ConfettiBottom> createState() => _ConfettiBottomState();
}

class _ConfettiBottomState extends State<ConfettiBottom> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConfettiWidget(
        confettiController: widget.controller,
        blastDirection: -pi / 2,
        emissionFrequency: 0.01,
        numberOfParticles: 20,
        maxBlastForce: 100,
        minBlastForce: 80,
        gravity: 0.3,
      ),
    );
  }
}

class ConfettiLeft extends StatefulWidget {
  final ConfettiController controller;
  const ConfettiLeft({
    super.key,
    required this.controller,
  });

  @override
  State<ConfettiLeft> createState() => _ConfettiLeftState();
}

class _ConfettiLeftState extends State<ConfettiLeft> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConfettiWidget(
        confettiController: widget.controller,
        blastDirection: 0, // radial value - RIGHT
        emissionFrequency: 0.6,
        minimumSize: const Size(10,
            10), // set the minimum potential size for the confetti (width, height)
        maximumSize: const Size(50,
            50), // set the maximum potential size for the confetti (width, height)
        numberOfParticles: 1,
        gravity: 0.1,
      ),
    );
  }
}

class ConfettiRight extends StatefulWidget {
  final ConfettiController controller;
  const ConfettiRight({
    super.key,
    required this.controller,
  });

  @override
  State<ConfettiRight> createState() => _ConfettiRightState();
}

class _ConfettiRightState extends State<ConfettiRight> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConfettiWidget(
        confettiController: widget.controller,
        blastDirection: pi, // radial value - LEFT
        particleDrag: 0.05, // apply drag to the confetti
        emissionFrequency: 0.05, // how often it should emit
        numberOfParticles: 20, // number of particles to emit
        gravity: 0.05, // gravity - or fall speed
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink
        ], // manually specify the colors to be used
        strokeWidth: 1,
        strokeColor: Colors.white,
      ),
    );
  }
}

class ConfettiCenter extends StatefulWidget {
  final ConfettiController controller;

  const ConfettiCenter({
    super.key,
    required this.controller,
  });

  @override
  State<ConfettiCenter> createState() => _ConfettiCenterState();
}

class _ConfettiCenterState extends State<ConfettiCenter> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: widget.controller,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop: false, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        createParticlePath: drawStar, // define a custom shape/path.
      ),
    );
  }
}
