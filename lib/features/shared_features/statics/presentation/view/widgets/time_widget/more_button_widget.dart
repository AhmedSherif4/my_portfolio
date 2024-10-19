part of '../../../../statics.dart';


class TextWithIconButton extends StatelessWidget {
  final Function() onTap;
  final String text;

  const TextWithIconButton(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: AppReference.themeData.textTheme.bodySmall!
                .copyWith(color: AppColors.primaryColor),
          ),
          10.sizedBoxWidth,
          Icon(
            Icons.arrow_forward_ios,
            size: AppSize.s12.responsiveSize,
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
