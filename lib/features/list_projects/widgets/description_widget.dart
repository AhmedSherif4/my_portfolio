import 'package:flutter/material.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';

import '../model/project_model.dart';

class DescriptionWidget extends StatelessWidget {
  final ProjectsModel project;

  const DescriptionWidget({Key? key, required this.project}) : super(key: key);

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
              style: AppTextStyle()
                  .black
                  .bodyMedium20w4
                  .copyWith(fontFamily: AppTextStyle.playfairDisplay),
            ),
          ),
          Expanded(
            child: Text(
              project.description,
              style: AppTextStyle().gray.labelSmall12w5,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
        ],
      ),
    );
  }
}
