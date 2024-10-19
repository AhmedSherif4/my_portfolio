import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/config/resources/app_assets.dart';
import 'package:my_portfolio/config/resources/app_colors.dart';
import 'package:my_portfolio/config/resources/app_text_style.dart';
import 'package:my_portfolio/config/responsive/responsive_extensions.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/shared_widget/custom_inkwell.dart';
import 'package:my_portfolio/core/shared_widget/error_widget.dart';
import 'package:my_portfolio/features/shared_features/quran/presentation/quran_widgets/to_arabic_no_converter.dart';
import '../../../../../config/resources/app_values.dart';
import '../../../../../core/base_widgets/loading_widget.dart';
import '../../../more/presentation/more_widgets/header_for_more.dart';
import '../../quran.dart';

class QuranPageScreen extends StatefulWidget {
  final int pageNumber;

  const QuranPageScreen({
    super.key,
    required this.pageNumber,
  });

  @override
  State<QuranPageScreen> createState() => _QuranPageScreenState();
}

class _QuranPageScreenState extends State<QuranPageScreen> {
  late final AudioPlayer _audioPlayer;
  late final PageController _pageController;
  var keys = [];
  late int current;
  int currentIndex = 0;
  bool showAudioBar = false;
  List<String> audioUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<QuranBloc, QuranState>(
          listener: (context, state){
            switch (state.getQuranTafseerState) {
              case RequestStates.loaded:
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (dialogContext) => StatefulBuilder(
                    builder: (dialogContext, setState) {
                      return AyaWithTafseerDialog(
                        descriptionText:
                        state.getQuranTafseerData[BlocProvider.of<QuranBloc>(context).index].text,
                        onAddPressed: () {
                          if (BlocProvider.of<QuranBloc>(context).index < state.getQuranTafseerData.length - 1) {
                            setState((){
                              BlocProvider.of<QuranBloc>(context).index++;
                            });
                          }
                        },
                        onMinasPressed: () {
                          if (BlocProvider.of<QuranBloc>(context).index > 0) {
                            setState((){
                              BlocProvider.of<QuranBloc>(context).index--;
                            });
                          }
                        },
                      );
                    },
                  ),
                );
              case RequestStates.loading:
                showLoadingDialog(context);
                break;
              case RequestStates.error:
                const Text("errrrrrrrror");
              default:
            }
          },
          builder: (context, state) {
            switch (state.getQuranPageState) {
              case RequestStates.loading:
                return const Text('sas');
              case RequestStates.loaded:
                return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      // value.log();
                      if (value >= current) {
                        if (current < 604) {
                          current++;
                          context.read<QuranBloc>().add(
                            GetQuranPageEvent(
                              pageNumber: current,
                            ),
                          );
                        }
                      } else {
                        if (current > 1) {
                          current--;
                          context.read<QuranBloc>().add(
                            GetQuranPageEvent(
                              pageNumber: current,
                            ),
                          );
                        }
                      }
                    },
                    itemCount: 604,
                    itemBuilder:
                        (context1, index) =>
                        Column(
                          children: [
                            HeaderForMore(
                              title: state.getQuranPageData[0].suruhName,
                              textColor: AppColors.primaryColor,
                            ),
                            AppSize.s20.sizedBoxHeight,
                            Wrap(
                                children:state.getQuranPageData.map( (e){
                                  var index = state.getQuranPageData.indexOf(e);
                                  return CustomInkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                            backgroundColor:AppColors.white,
                                            context: context,
                                            builder: (_) {
                                              currentIndex = index;
                                              switch (state
                                                  .getQuranPageState) {
                                                case RequestStates
                                                    .loading:
                                                  return const Text(
                                                      'sas');
                                                case RequestStates
                                                    .loaded:
                                                  if (state
                                                      .getQuranPageData
                                                      .isEmpty) {
                                                    return const EmptyListView();
                                                  } else {
                                                    return Container(
                                                      padding:
                                                      const EdgeInsets.all(16.0),
                                                      child:
                                                      Builder(
                                                          builder: (context2) {
                                                            return Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: <Widget>[
                                                                const SizedBox(height: 16.0),
                                                                Row(
                                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    CustomInkWell(
                                                                        onTap: ()  async{
                                                                          isPlaying = true;
                                                                          setState(() {
                                                                            showAudioBar=true;
                                                                          });
                                                                          await _audioPlayer.play(UrlSource(e.audio!));
                                                                          // '${await _audioPlayer.onDurationChanged.length}'.log();

                                                                          if (index == 0) {
                                                                            _audioPlayer.onPlayerComplete.listen((_) {
                                                                              //int j = i + 1;
                                                                              // '${_audioPlayer.onDurationChanged.length}'.log();
                                                                              _audioPlayer.play(UrlSource(state.getQuranPageData[currentIndex++].audio!));
                                                                            });
                                                                          } else if (index == state.getQuranPageData.length - 1) {
                                                                            _audioPlayer.onPlayerComplete.listen((_) {
                                                                              _audioPlayer.pause();
                                                                              // _audioPlayer.play(UrlSource(state.getQuranPageData[i].audio!));
                                                                            });
                                                                          }
                                                                        },
                                                                        child:  CircleAvatar(

                                                                          radius:25,
                                                                          backgroundColor:AppColors.primaryColor,

                                                                          child:
                                                                          Column(
                                                                            mainAxisAlignment:MainAxisAlignment.center,
                                                                            crossAxisAlignment:CrossAxisAlignment.center,
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                AppIconsAssets.sQuranTelawa,
                                                                                fit: BoxFit.fill,
                                                                                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                                                              ),
                                                                              10.sizedBoxWidth,
                                                                              Text("تلاوة",style: AppTextStyle.cacheBodySmall12(10).copyWith(color: AppColors.white,),),
                                                                            ],
                                                                          ),

                                                                        )

                                                                    ),
                                                                    CustomInkWell(
                                                                        onTap: () {
                                                                          BlocProvider.of<QuranBloc>(context).index=index;
                                                                          BlocProvider.of<QuranBloc>(context).add(GetQuranTafseerEvent(
                                                                            quranParameter: QuranParameter(
                                                                              typeOfSelection: TypeOfSelection.page,
                                                                              selectionId: current,
                                                                              selectionText: 'name',
                                                                            ),
                                                                          ));
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child:  CircleAvatar(
                                                                          backgroundColor:AppColors.primaryColor,
                                                                          radius:25,
                                                                          child:
                                                                          Column(
                                                                            mainAxisAlignment:MainAxisAlignment.center,
                                                                            crossAxisAlignment:CrossAxisAlignment.center,

                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                AppIconsAssets.sQuranTafseer,
                                                                                fit: BoxFit.fill,
                                                                                colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                                                              ),
                                                                              10.sizedBoxWidth,
                                                                              Text("تفسيير",style: AppTextStyle.cacheBodySmall12(10).copyWith(
                                                                                  color: AppColors.white),
                                                                              ),
                                                                            ],
                                                                          ),

                                                                        )

                                                                    ),


                                                                  ],

                                                                ),
                                                                10.sizedBoxHeight,
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: <Widget>[
                                                                    CustomInkWell(
                                                                        onTap: () {
                                                                          if (currentIndex > 0) {
                                                                            if (isPlaying) {
                                                                              _audioPlayer.pause();
                                                                              currentIndex = currentIndex - 1;
                                                                              _audioPlayer.play(UrlSource(e.audio!));
                                                                            }
                                                                          }
                                                                        },
                                                                        child:  SvgPicture.asset(
                                                                          AppIconsAssets.sBackButton,
                                                                          fit: BoxFit.fitHeight,
                                                                        )

                                                                    ),
                                                                    CustomInkWell(
                                                                        onTap: ()async {
                                                                          if (isPlaying) {
                                                                            await _audioPlayer.pause();
                                                                          } else {
                                                                            await _audioPlayer.resume();
                                                                          }
                                                                          setState(() {
                                                                            isPlaying = !isPlaying;
                                                                          });
                                                                        },
                                                                        child:  SvgPicture.asset(
                                                                          !isPlaying ? AppIconsAssets.sPauseButton :  AppIconsAssets.sPlayButton,
                                                                          fit: BoxFit.fitHeight,
                                                                        )
                                                                    ),
                                                                    CustomInkWell(
                                                                        onTap: ()async {
                                                                          if (currentIndex < state.getQuranPageData.length - 1) {
                                                                            if (isPlaying) {
                                                                              _audioPlayer.pause();
                                                                              currentIndex = currentIndex + 1;
                                                                              _audioPlayer.play(UrlSource(state.getQuranPageData[currentIndex].audio!));
                                                                            }
                                                                          }
                                                                        },
                                                                        child:  SvgPicture.asset(
                                                                          AppIconsAssets.sNextButton,
                                                                          fit: BoxFit.fitHeight,
                                                                        )
                                                                    ),
                                                                  ],
                                                                ),

                                                              ],
                                                            );
                                                          }
                                                      ),
                                                    );
                                                  }
                                                case RequestStates
                                                    .error:
                                                  return CustomErrorWidget(
                                                    errorMessage:
                                                    state
                                                        .getQuranPageMessage,
                                                    onRefresh:
                                                        () async {
                                                      context
                                                          .read<QuranBloc>()
                                                          .add(
                                                        GetQuranPageEvent(
                                                          pageNumber: widget.pageNumber,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                default:
                                                  return const SizedBox();
                                              }
                                            });
                                      },
                                      child: Wrap(
                                        children: [
                                          Text(e.text,
                                            style: AppTextStyle.cacheTitleMedium20(AppFontSize.sp20).copyWith(
                                                fontFamily: AppTextStyle.quranFont,
                                                fontWeight: AppFontWeight.regularW400
                                            ),
                                          ),

                                          Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Image.asset(
                                                AppIconsAssets.sAyahTarqeem,
                                                fit: BoxFit.fitHeight,
                                              ),
                                              Text((e.numberInSurah).toArabicNumbers,)
                                            ],
                                          ),

                                        ],
                                      ));
                                }).toList()
                            ),
                          ],
                        ));
              case RequestStates.error:
                return CustomErrorWidget(
                    errorMessage: state.getQuranPageMessage);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ).paddingBody(),
    );
  }

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    current = widget.pageNumber;
    _pageController = PageController(initialPage: widget.pageNumber);
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
}