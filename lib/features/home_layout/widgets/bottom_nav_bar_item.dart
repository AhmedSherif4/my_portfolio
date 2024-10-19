part of '../home_layout.dart';

class BottomNavBarItemWidget extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final double widthRatio;
  final String label;
  final String imageIconPath;
  final BoxConstraints constrains;

  const BottomNavBarItemWidget({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.label,
    required this.imageIconPath,
    required this.constrains,
    this.widthRatio = 0.15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: SizedBox(
        width: constrains.maxWidth * widthRatio,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              imageIconPath,
              height: isSelected
                  ? constrains.maxHeight * 0.65
                  : constrains.maxHeight * 0.6,
              fit: isSelected ? BoxFit.contain : BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            if (!isSelected)
              SizedBox(
                height: constrains.maxHeight * 0.3,
                child: FittedBox(
                  child: Text(label, style: const AppTextStyle().white.bodyMedium14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
