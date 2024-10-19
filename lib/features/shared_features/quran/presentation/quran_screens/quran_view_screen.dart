part of '../../quran.dart';

class QuranViewScreen extends StatefulWidget {
  final QuranParameter data;

  const QuranViewScreen({
    super.key,
    required this.data,
  });

  @override
  State<QuranViewScreen> createState() => _QuranViewScreenState();
}

class _QuranViewScreenState extends State<QuranViewScreen>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    _lottieController
      ..reset()
      ..repeat();

    return Scaffold(
        body: SafeArea(
      child: Container(
        height: AppReference.deviceHeight(context),
        // width: AppReference.deviceWidth(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppReference.deviceIsTablet &&
                        !AppReference.isPortrait(context)
                    ? AppImagesAssets.pQuranForTabletBg
                    : AppImagesAssets.pQuranForMobileBg),
                fit: BoxFit.fill)),
        child: BlocConsumer<QuranBloc, QuranState>(
          listener: (context, state) {
            switch (state.getQuranTafseerState) {
              case RequestStates.loaded:
                Navigator.pop(context);
                showTafseerDialog(
                  context: context,
                  descriptionText: state.currentTafseerAyah?.text ?? '',
                );
              case RequestStates.loading:
                showLoadingDialog(context);
              default:
            }
          },
          builder: (context, state) {
            switch (state.getQuranAudioState) {
              case RequestStates.loaded:
                if (state.getQuranAudioData.isEmpty) {
                  return const EmptyListView();
                } else {
                  return Column(
                    children: [
                      HeaderForMore(
                        title: widget.data.selectionText,
                        textColor: AppColors.primaryColor,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ResponsiveWidgetForTablet(
                            mobile: OrientationItem(
                              portraitWidget: Column(
                                children: [
                                  StatefulBuilder(
                                      builder: (context, updateState) {
                                    _audioPlayer.onPlayerStateChanged
                                        .listen((event) {
                                      if (event == PlayerState.playing) {
                                        if (mounted) {
                                          updateState(() {
                                            isPlaying = true;
                                          });
                                        } else {
                                          updateState(() {
                                            isPlaying = false;
                                          });
                                        }
                                      }
                                    });
                                    return Image.asset(
                                      AppImagesAssets.pQuranImage,
                                      width:
                                          AppReference.deviceWidth(context) * 0.7,
                                      height: AppReference.deviceHeight(context) *
                                          0.3,
                                    );
                                  }),
                                  AppSize.s20.sizedBoxHeight,
                                  Row(
                                    children: [
                                      BackButton(
                                          state: state,
                                          audioPlayer: _audioPlayer),
                                      SizedBox(
                                        height: 100.responsiveHeight,
                                        width: AppReference.deviceWidth(context) *
                                            0.5,
                                        child: _AudioWidgetForQuran(
                                            isPlaying: state.isAudioPlaying,
                                            onPressed: () {
                                              _audioPlaying(state);

                                            }),
                                      ),
                                      NextButton(
                                          state: state,
                                          audioPlayer: _audioPlayer),
                                    ],
                                  ),
                                  _AyaPortraitViewWidget(
                                    widget: widget,
                                    currentAya: state.currentAyah!.text,
                                  ),
                                ],
                              ),
                              landscapeWidget:  Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: AppReference.deviceWidth(context) *
                                        0.25,
                                    child: StatefulBuilder(
                                        builder: (context, updateState) {
                                          _audioPlayer.onPlayerStateChanged
                                              .listen((event) {
                                            if (event == PlayerState.playing) {
                                              if (mounted) {
                                                updateState(() {
                                                  isPlaying = true;
                                                });
                                              } else {
                                                updateState(() {
                                                  isPlaying = false;
                                                });
                                              }
                                            }
                                          });
                                          return isPlaying
                                              ? Lottie.asset(
                                            AppLottieAssets.sManReadQuran,
                                            controller: _lottieController,
                                            width: AppReference.deviceWidth(
                                                context) *
                                                0.3,
                                            height: AppReference.deviceHeight(
                                                context) *
                                                0.5,
                                          )
                                              : Image.asset(
                                            AppImagesAssets.pQuranImage,
                                            width: AppReference.deviceWidth(
                                                context) *
                                                0.3,
                                            height: AppReference.deviceHeight(
                                                context) *
                                                0.5,
                                          );
                                        }),
                                  ),
                                  Container(
                                    width: AppReference.deviceWidth(context) *
                                        0.65,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.responsiveSize,
                                      horizontal: 20.responsiveSize,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                      AppColors.quranColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(
                                          AppConstants
                                              .appPaddingR20.responsiveSize),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: AppReference.deviceWidth(
                                                    context) *
                                                    0.07,
                                                child: BackButton(
                                                    state: state,
                                                    audioPlayer: _audioPlayer)),
                                            SizedBox(
                                              height: 150.responsiveHeight,
                                              width: AppReference.deviceWidth(
                                                  context) *
                                                  0.2,
                                              child: _AudioWidgetForQuran(
                                                  isPlaying: state.isAudioPlaying,
                                                  onPressed: () {
                                                    _audioPlaying(state);
                                                  }),
                                            ),
                                            SizedBox(
                                                width: AppReference.deviceWidth(
                                                    context) *
                                                    0.07,
                                                child: NextButton(
                                                    state: state,
                                                    audioPlayer: _audioPlayer)),
                                          ],
                                        ),
                                        AppSize.s20.sizedBoxHeight,
                                        CustomInkWell(
                                          onTap: () {
                                            context.read<QuranBloc>().add(
                                                GetQuranTafseerEvent(
                                                    quranParameter:
                                                    widget.data));
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                AppStrings.hintOfAya,
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .bodySmall12,
                                                textAlign: TextAlign.justify,
                                              ),
                                              AppSize.s10.sizedBoxWidth,
                                              SvgPicture.asset(
                                                  AppIconsAssets.sAdultHint),
                                            ],
                                          ),
                                        ),
                                        AppSize.s20.sizedBoxHeight,

                                        Text(
                                          state.currentAyah!.text,
                                          style: const AppTextStyle()
                                              .quranFont
                                              .s24
                                              .w100
                                              .titleMedium20,
                                          textAlign: TextAlign.justify,
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            tablet: OrientationItem(
                              portraitWidget: Column(
                                children: [
                                  StatefulBuilder(
                                      builder: (context, updateState) {
                                    _audioPlayer.onPlayerStateChanged
                                        .listen((event) {
                                      if (event == PlayerState.playing) {
                                        if (mounted) {
                                          updateState(() {
                                            isPlaying = true;
                                          });
                                        } else {
                                          updateState(() {
                                            isPlaying = false;
                                          });
                                        }
                                      }
                                    });
                                    return isPlaying
                                        ? Lottie.asset(
                                            AppLottieAssets.sManReadQuran,
                                            controller: _lottieController,
                                            width: AppReference.deviceWidth(
                                                    context) *
                                                0.7,
                                            height: AppReference.deviceHeight(
                                                    context) *
                                                0.3,
                                          )
                                        : Image.asset(
                                            AppImagesAssets.pQuranImage,
                                            width: AppReference.deviceWidth(
                                                    context) *
                                                0.7,
                                            height: AppReference.deviceHeight(
                                                    context) *
                                                0.3,
                                          );
                                  }),
                                  AppSize.s20.sizedBoxHeight,
                                  Row(
                                    children: [
                                      BackButton(
                                          state: state,
                                          audioPlayer: _audioPlayer),
                                      SizedBox(
                                        height: 100.responsiveHeight,
                                        width:
                                            AppReference.deviceWidth(context) *
                                                0.5,
                                        child: _AudioWidgetForQuran(
                                            isPlaying: state.isAudioPlaying,
                                            onPressed: () {
                                              _audioPlaying(state);
                                            }),
                                      ),
                                      NextButton(
                                          state: state,
                                          audioPlayer: _audioPlayer),
                                    ],
                                  ),
                                  _AyaPortraitViewWidget(
                                    widget: widget,
                                    currentAya: state.currentAyah!.text,
                                  ),
                                ],
                              ),
                              landscapeWidget: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: AppReference.deviceWidth(context) *
                                        0.25,
                                    child: StatefulBuilder(
                                        builder: (context, updateState) {
                                      _audioPlayer.onPlayerStateChanged
                                          .listen((event) {
                                        if (event == PlayerState.playing) {
                                          if (mounted) {
                                            updateState(() {
                                              isPlaying = true;
                                            });
                                          } else {
                                            updateState(() {
                                              isPlaying = false;
                                            });
                                          }
                                        }
                                      });
                                      return isPlaying
                                          ? Lottie.asset(
                                              AppLottieAssets.sManReadQuran,
                                              controller: _lottieController,
                                              width: AppReference.deviceWidth(
                                                      context) *
                                                  0.3,
                                              height: AppReference.deviceHeight(
                                                      context) *
                                                  0.5,
                                            )
                                          : Image.asset(
                                              AppImagesAssets.pQuranImage,
                                              width: AppReference.deviceWidth(
                                                      context) *
                                                  0.3,
                                              height: AppReference.deviceHeight(
                                                      context) *
                                                  0.5,
                                            );
                                    }),
                                  ),
                                  Container(
                                    width: AppReference.deviceWidth(context) *
                                        0.65,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.responsiveSize,
                                      horizontal: 20.responsiveSize,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.quranColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(
                                          AppConstants
                                              .appPaddingR20.responsiveSize),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          state.currentAyah!.text,
                                          style: const AppTextStyle()
                                              .quranFont
                                              .s24
                                              .w100
                                              .titleMedium20,
                                          textAlign: TextAlign.justify,
                                        ),
                                        AppSize.s20.sizedBoxHeight,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: AppReference.deviceWidth(
                                                        context) *
                                                    0.07,
                                                child: BackButton(
                                                    state: state,
                                                    audioPlayer: _audioPlayer)),
                                            SizedBox(
                                              height: 150.responsiveHeight,
                                              width: AppReference.deviceWidth(
                                                      context) *
                                                  0.2,
                                              child: _AudioWidgetForQuran(
                                                  isPlaying:
                                                      state.isAudioPlaying,
                                                  onPressed: () {
                                                    _audioPlaying(state);
                                                  }),
                                            ),
                                            SizedBox(
                                                width: AppReference.deviceWidth(
                                                        context) *
                                                    0.07,
                                                child: NextButton(
                                                    state: state,
                                                    audioPlayer: _audioPlayer)),
                                          ],
                                        ),
                                        AppSize.s20.sizedBoxHeight,
                                        CustomInkWell(
                                          onTap: () {
                                            context.read<QuranBloc>().add(
                                                GetQuranTafseerEvent(
                                                    quranParameter:
                                                        widget.data));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                AppStrings.hintOfAya,
                                                style: const AppTextStyle()
                                                    .balooBhaijaan2
                                                    .w500
                                                    .bodySmall12,
                                                textAlign: TextAlign.justify,
                                              ),
                                              AppSize.s10.sizedBoxWidth,
                                              SvgPicture.asset(
                                                  AppIconsAssets.sAdultHint),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              case RequestStates.loading:
                return const LoadingShimmerList();
              case RequestStates.error:
                return CustomErrorWidget(
                  errorMessage: state.getQuranAudioMessage,
                  onRefresh: () async {
                    context.read<QuranBloc>().add(
                          GetQuranAudioEvent(
                            quranParameter: widget.data,
                          ),
                        );
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ).paddingBody(),
      ),
    ));
  }

  void _audioPlaying(QuranState state) {
    if (state.isAudioPlaying) {
      //  _lottieController.stop();
      isPlaying = false;
      _audioPlayer.pause();
    } else {
      isPlaying = true;
      _audioPlayer.play(UrlSource(state.currentAyah!.audio!));
      //  _lottieController.forward();
    }
    context.read<QuranBloc>().add(
          ChangeAudioStateEvent(
            isPlaying: !state.isAudioPlaying,
          ),
        );
  }

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _audioPlayer.onPlayerComplete.listen((_) {
      if(!mounted) return;
      context.read<QuranBloc>().add(
            const ChangeAudioStateEvent(
              isPlaying: false,
            ),
          );
    });
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}

class _AyaPortraitViewWidget extends StatelessWidget {
  const _AyaPortraitViewWidget({
    required this.widget,
    required this.currentAya,
  });

  final QuranViewScreen widget;
  final String currentAya;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(8.0.responsiveSize),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.responsiveHeight,
            horizontal: 30.responsiveWidth,
          ),
          decoration: BoxDecoration(
            color: AppColors.quranColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(
                AppConstants.appPaddingR20.responsiveSize),
          ),
          child: Column(
            children: [
              Text(
                currentAya,
                style: const AppTextStyle().quranFont.s24.w100.titleMedium20,
                textAlign: TextAlign.justify,
              ),
              AppSize.s20.sizedBoxHeight,
              CustomInkWell(
                onTap: () {
                  context
                      .read<QuranBloc>()
                      .add(GetQuranTafseerEvent(quranParameter: widget.data));
                },
                child: Row(
                  children: [
                    Text(
                      AppStrings.hintOfAya,
                      style:
                          const AppTextStyle().balooBhaijaan2.w500.bodySmall12,
                      textAlign: TextAlign.justify,
                    ),
                    AppSize.s10.sizedBoxWidth,
                    SvgPicture.asset(AppIconsAssets.sAdultHint),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextOrBackButtonWidget extends StatelessWidget {
  final QuranState state;
  final bool isNextButton;
  final AudioPlayer audioPlayer;
  const NextOrBackButtonWidget({
    super.key,
    required this.state,
    required this.isNextButton,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.responsiveSize),
          boxShadow: const [
            AppShadow.outerShadow,
          ]),
      width: AppReference.deviceWidth(context) * 0.2,
      child: IconButton.filled(
        onPressed: () {
          audioPlayer.stop();
          context.read<QuranBloc>().add(
                ChangeAyahEvent(
                  index: isNextButton
                      ? state.currentIndex + 1
                      : state.currentIndex - 1,
                ),
              );

          context.read<QuranBloc>().add(
            const ChangeAudioStateEvent(
              isPlaying: false,
            ),
          );

        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
          shadowColor: WidgetStateProperty.all(Colors.black),
        ),
        icon: Icon(
          isNextButton
              ? Icons.arrow_forward_ios_rounded
              : Icons.arrow_back_ios_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final QuranState state;
  final AudioPlayer audioPlayer;

  const NextButton({super.key, required this.state, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return switch (state.getQuranAudioData.length > state.currentIndex + 1) {
      true => NextOrBackButtonWidget(
          state: state,
          isNextButton: true,
          audioPlayer: audioPlayer,
        ),
      false => SizedBox(width: AppReference.deviceWidth(context) * 0.2),
    };
  }
}

class BackButton extends StatelessWidget {
  final QuranState state;
  final AudioPlayer audioPlayer;

  const BackButton({super.key, required this.state, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return switch (state.getQuranAudioData.length >= state.currentIndex + 1 &&
        state.currentIndex > 0) {
      true => NextOrBackButtonWidget(
          state: state,
          isNextButton: false,
          audioPlayer: audioPlayer,
        ),
      false => SizedBox(
          width: AppReference.deviceIsTablet
              ? AppReference.deviceWidth(context) * 0.05
              : AppReference.deviceWidth(context) * 0.2),
    };
  }
}

class DataView extends StatelessWidget {
  const DataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class EmptyListView extends StatelessWidget {
  const EmptyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyListWidgets(message: AppStrings.emptyQuestionsList),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('رجوع'),
        ),
      ],
    );
  }
}
