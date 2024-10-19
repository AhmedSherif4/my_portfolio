import 'package:flutter/material.dart';
import '../../../data/show_parent_child_other_side_model.dart';
class ShowParentChildOtherSideItem extends StatelessWidget {
  const ShowParentChildOtherSideItem({super.key, required this.showParentChildOtherSideModel});
  final ShowParentChildOtherSideModel showParentChildOtherSideModel;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(showParentChildOtherSideModel.image),
          ),
        ),
      ],
    );
  }
}
