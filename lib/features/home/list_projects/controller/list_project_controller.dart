import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../model/project_model.dart';

class ListProjectsController {
  double itemSize(context) => MediaQuery.sizeOf(context).shortestSide < 550
      ? 200.responsiveWidth
      : 180.0.responsiveWidth;
  late ScrollController listController;

  double getScale(int index, BuildContext context) {
    double scale = getPercent(index, context);
    if (scale > 1.0) scale = 1.0;
    return scale.clamp(0.5, 1.5);
  }

  double getPercent(int index, BuildContext context) {
    final offset = index * itemSize(context);
    final diference = listController.offset - offset;
    final percent = 1 - (diference / (itemSize(context) / 2));
    return percent;
  }

  double getOpacity(int index, BuildContext context) {
    final percent = getPercent(index, context);
    double opacity = percent;
    if (opacity > 1.0) opacity = 1.0;
    if (opacity < 0.0) opacity = 0.0;
    return opacity;
  }

  List<ProjectsModel> projects = [
    ProjectsModel(
      name: "Taseese",
      description:
          'An educational application that contains educational stages that suit all ages. In each stage there is a group of classes and we have materials for all stages and sub-sections for each subject. There is a group of questions for each section that you can evaluate your performance, solve tests and raise your educational level.',
      imageUrl: AppIconsAssets.pTaseese,
      androidLink:
          'https://play.google.com/store/apps/details?id=com.edu_tasses.tasesse_app&pli=1',
      iosLink:
          'https://apps.apple.com/eg/app/taseese-%D8%AA%D8%A3%D8%B3%D9%8A%D8%B3/id6477544252',
    ),
    ProjectsModel(
      name: "Mideo",
      description:
          "Mideo is a comprehensive medical education app specifically designed to Interactive medical courses and educational content. Easy-to-use appointment booking and payment processing. Personalized customer support for all your queries. Real-time notifications for updates, promotions, and more. Safe and secure handling of your personal and financial information. Whether you're studying for exams, seeking professional development, or managing your healthcare needs, Mideo is here to support you every step of the way. Download now and take control of your medical journey!",
      imageUrl: AppIconsAssets.pMideoApp,
      androidLink:
          'https://play.google.com/store/apps/details?id=com.medkingApp.mideo',
      iosLink: 'https://apps.apple.com/app/mideo-app/id6749076532',
    ),
    ProjectsModel(
      name: "Medking",
      description:
          'MedKing is a comprehensive medical educational app specifically designed to meet your learning needs in the medical field. Whether you are a medical student, a practicing physician, or simply interested in learning about medical topics, MedKing provides you with the tools and resources you need to expand your knowledge and improve your skills.',
      imageUrl: AppIconsAssets.pMedkingApp,
      androidLink:
          'https://play.google.com/store/apps/details?id=com.medkingApp.mideo',
      iosLink: 'https://apps.apple.com/us/app/medking/id6664068510',
    ),
    ProjectsModel(
      name: "E Commerce",
      description:
          "A modern eCommerce mobile application built using Flutter with a Clean Architecture pattern. The project is designed for scalability, maintainability, and testability — integrating Bloc/Cubit for state management, GetIt for dependency injection, Supabase as the backend, Dio for API handling, Hive for local storage, and Firebase for analytics and services.",
      imageUrl: AppIconsAssets.pECommerceApp,
      githubLink: 'https://github.com/AhmedSherif4/ecommerce_app',
    ),
    ProjectsModel(
      name: "Chat App",
      description:
          "A modern Chat mobile application built using Flutter with a Clean Architecture pattern. The project is designed for scalability, maintainability, and testability — integrating Bloc/Cubit for state management, GetIt for dependency injection, Supabase as the backend, Dio for API handling, Hive for local storage, and Firebase for analytics and services.",
      imageUrl: AppIconsAssets.pChatApp,
      githubLink: 'https://github.com/AhmedSherif4/chat_app',
    ),
    ProjectsModel(
      name: "To Do Do",
      description:
          "A To-do project with Dart/Light mode, for making Todo with a Title and Description, also can make the Todo daily, weekly, and monthly repeat. and change the color of Todo, There's a Complete/unComplete option, and select all as complete. There is also a page for counting the Todos which is completed and which is not.",
      imageUrl: AppIconsAssets.pToDoDO,
      githubLink: 'https://github.com/AhmedSherif4/to_do_do#readme',
    ),
    ProjectsModel(
      name: "Posts App",
      description: "Posts App Built with Flutter",
      imageUrl: AppIconsAssets.pPostsApp,
      githubLink: 'https://github.com/AhmedSherif4/posts_app',
    ),
    ProjectsModel(
      name: "Tick Tack",
      description: "X/O Game Built with Flutter",
      imageUrl: AppIconsAssets.pTickTack,
      githubLink: 'https://github.com/AhmedSherif4/tick_tack',
    ),
    ProjectsModel(
      name: "Point Counter",
      description:
          "A project for counting the number of points for two players, when one of the players reaches the Limit Points -which you select-, the application will declare the winner.",
      imageUrl: AppIconsAssets.pPointCounter,
      githubLink: 'https://github.com/AhmedSherif4/point_counter#readme',
    ),
    ProjectsModel(
      name: "Sky Cast",
      description:
          "A project for showing the weather of any city you want, and has an option for making dart/light mode (and the primary color depending on the current weather) and making the temperature units Fahrenheit / celsius.",
      imageUrl: AppIconsAssets.pSkyCase,
      githubLink: 'https://github.com/AhmedSherif4/sky_cast#readme',
    ),
  ];
}
