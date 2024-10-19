part of '../on_boarding.dart';


class ImageWidget extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;
  final int pageCount;

  const ImageWidget({
    super.key,
    required this.pageController,
    required this.pageCount,
    required this.onPageChanged,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: onBoardingPagesData.length,
      onPageChanged: widget.onPageChanged,
      itemBuilder: (context, index) {
        return Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  onBoardingPagesData[widget.pageCount]['image'],
                ),
              ),
              TitleWidget(pageCount: widget.pageCount),
              AppSize.s20.sizedBoxHeight,
              Expanded(
                child: SingleChildScrollView(
                    child: DescriptionWidget(pageCount: widget.pageCount)),
              ),
              //20.sizedBoxHeight,
            ]
        );
      },
    );
  }
}


class ImageWidgetForTablet extends StatefulWidget {
  final PageController pageController;
  final Function(int) onPageChanged;
  final int pageCount;

  const ImageWidgetForTablet({
    super.key,
    required this.pageController,
    required this.pageCount,
    required this.onPageChanged,
  });

  @override
  State<ImageWidgetForTablet> createState() => _ImageWidgetForTabletState();
}

class _ImageWidgetForTabletState extends State<ImageWidgetForTablet> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      itemCount: onBoardingPagesData.length,
      onPageChanged: widget.onPageChanged,
      itemBuilder: (context, index) {
        return


          SvgPicture.asset(
          onBoardingPagesData[widget.pageCount]['image'],
          fit: BoxFit.contain,
        );
      },
    );
  }
}