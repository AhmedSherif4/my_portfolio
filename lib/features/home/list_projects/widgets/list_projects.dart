import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/my_app/app_reference.dart';

import '../controller/list_project_controller.dart';
import '../model/project_model.dart';
import 'description_widget.dart';

class ProjectsShowWidget extends StatefulWidget {
  const ProjectsShowWidget({super.key});

  @override
  State<ProjectsShowWidget> createState() => _ProjectsShowWidgetState();
}

class _ProjectsShowWidgetState extends State<ProjectsShowWidget>
    with TickerProviderStateMixin {
  late ListProjectsController _controller;
  late AnimationController _animationController;

  late Tween<double> tween;
  double angle = 0;

  late Animation<double> animation;

  late Size size;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.decelerate));
    _controller = ListProjectsController();
    _controller.listController = ScrollController();
    _controller.listController.addListener(_listenListController);

    _animationController.addListener(() {
      setState(() {
        angle = animation.value;
      });
    });

    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
        }
      },
    );
  }

  void _listenListController() {
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();

    _controller.listController.removeListener(_listenListController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.responsiveSize),
      height: AppReference.deviceHeight(context) * 0.8,
      width: AppReference.deviceWidth(context),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        controller: _controller.listController,
        itemCount: _controller.projects.length,
        itemBuilder: (_, index) {
          double scale = _controller.getScale(index, context);
          return Opacity(
            opacity: _controller.getOpacity(index, context),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, .002)
                ..rotateX((pi * scale) + 3.2),
              child: _itemList(
                _controller.projects[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _itemList(ProjectsModel project) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(8.0.responsiveSize),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.responsiveWidth),
          alignment: Alignment.center,
          width: AppReference.deviceWidth(context) * 0.5,
          height: AppReference.deviceHeight(context) * 0.6,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                width: AppReference.deviceWidth(context) * 0.5,
                height: AppReference.deviceHeight(context) * 0.5,
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0.responsiveSize),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      project.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: (AppReference.deviceIsTablet) ? 30 : null,
                left: (AppReference.deviceIsTablet) ? 0 : null,
                bottom: (!AppReference.deviceIsTablet) ? 130 : null,
                width: AppReference.deviceWidth(context) *
                    (AppReference.deviceIsTablet ? 0.2 : 0.4),
                height: AppReference.deviceHeight(context) *
                    (AppReference.deviceIsTablet ? 0.4 : 0.3),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi * angle),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: const Offset(2.0, 5.0),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        child: DescriptionWidget(project: project)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
