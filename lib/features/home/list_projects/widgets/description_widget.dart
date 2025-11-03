import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../model/project_model.dart';

class DescriptionWidget extends StatelessWidget {
  final ProjectsModel project;

  const DescriptionWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return _description();
  }

  Widget _description() {
    return Padding(
      padding: EdgeInsets.all(10.responsiveSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              project.name,
              style: const AppTextStyle()
                  .black
                  .bodyMedium20w4
                  .copyWith(fontFamily: AppTextStyle.playfairDisplay),
            ),
          ),
          Expanded(
            child: Text(
              project.description,
              style: const AppTextStyle().gray.labelSmall12w5,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }
}
