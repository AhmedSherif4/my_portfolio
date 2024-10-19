part of '../../download_upload.dart';

class ChildDownloadUploadScreen extends StatefulWidget {
  final DataToGoUploadExam dataToGoUploadScreen;

  const ChildDownloadUploadScreen({
    super.key,
    required this.dataToGoUploadScreen,
  });

  @override
  State<ChildDownloadUploadScreen> createState() =>
      _ChildDownloadUploadScreenState();
}

class _ChildDownloadUploadScreenState extends State<ChildDownloadUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.dataToGoUploadScreen.isPrimary)
            Image.asset(
              AppImagesAssets.sPrimaryChildBackground,
              fit: BoxFit.fill,
            ),
          SafeArea(
            child: SingleChildScrollView(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<DownloadUploadBloc, DownloadUploadState>(
                    listenWhen: (p, c) => p != c,
                    listener: (listenerContext, state) {
                      switch (state.pickFileStates) {
                        case RequestStates.loaded:
                          listenerContext.read<DownloadUploadBloc>().add(
                                UploadFileEvent(
                                  parameters: UploadParameters(
                                    file: state.pickedFile!,
                                    exam:
                                        widget.dataToGoUploadScreen.examEntity,
                                    index: widget.dataToGoUploadScreen.index,
                                    subjectId: widget.dataToGoUploadScreen
                                        .examEntity.subjectId,
                                  ),
                                ),
                              );
                        case RequestStates.error:
                          showSnackBar(
                            description: state.pickFileErrorMessage,
                            state: ToastStates.error,
                            context: listenerContext,
                          );
                        default:
                      }

                      switch (state.uploadFileStates) {
                        case RequestStates.loading:
                          showLoadingDialog(listenerContext);
                        case RequestStates.loaded:
                          Navigator.pop(listenerContext);
                          showSnackBar(
                              description: state.uploadFileSuccessMessage,
                              state: ToastStates.congrats,
                              context: listenerContext);
                          context.read<DownloadUploadBloc>().add(
                                UpdateDataAfterUploadEvent(
                                  parameters: UploadParameters(
                                    file: state.pickedFile!,
                                    exam:
                                        widget.dataToGoUploadScreen.examEntity,
                                    index: widget.dataToGoUploadScreen.index,
                                    subjectId: widget.dataToGoUploadScreen
                                        .examEntity.subjectId,
                                  ),
                                ),
                              );
                        case RequestStates.error:
                          Navigator.pop(listenerContext);
                          showSnackBar(
                            description: state.uploadFileErrorMessage,
                            state: ToastStates.error,
                            context: listenerContext,
                          );
                        default:
                      }

                      switch (state.updateDataAfterUploadState) {
                        case RequestStates.error:
                          showSnackBar(
                            description:
                                state.updateDataAfterUploadErrorMessage,
                            state: ToastStates.error,
                            context: context,
                          );
                        default:
                      }
                    },
                  ),
                  BlocListener<DownloadBloc, DownloadState>(
                      listener: (downloadListenerContext, downloadState) {
                    switch (downloadState.downloadFileStates) {
                      case RequestStates.loading:
                        Future.delayed(Duration.zero, () {
                          if (context.mounted) {
                            showDialog(
                              context: downloadListenerContext,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  child: AlertDialog(
                                    content: StreamBuilder<int>(
                                      stream: BlocProvider.of<DownloadBloc>(
                                              downloadListenerContext)
                                          .progressController
                                          .stream
                                          .asBroadcastStream(),
                                      builder: (context, snapshot) {
                                        return ProgressBarWithCircle(
                                          progressValue: double.parse(
                                              '${snapshot.data ?? 0}'),
                                          width: AppReference.deviceWidth(
                                                  context) *
                                              .5,
                                          height: AppReference.deviceHeight(
                                                  context) *
                                              .2,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        });
                      case RequestStates.loaded:
                        Navigator.pop(context);
                        showSnackBar(
                            description: AppReference.deviceIsIos
                                ? downloadState.downloadFileMessage
                                : '${downloadState.downloadFileMessage}  \n   سوف تجد الإمتحان في   download/exams',
                            state: ToastStates.congrats,
                            context: downloadListenerContext);
                      case RequestStates.error:
                        Navigator.pop(context);
                        showSnackBar(
                            description: downloadState.downloadFileMessage,
                            state: ToastStates.error,
                            context: downloadListenerContext);
                      default:
                    }
                  })
                ],
                child: Column(
                  children: [
                    const HeaderForTermsAndLevelsAndGroup(
                      title: AppStrings.chooseSubject,
                    ),
                    Hero(
                      tag: widget.dataToGoUploadScreen.examEntity.id,
                      child: _TitleWidget(
                        title: widget.dataToGoUploadScreen.examEntity.name,
                        isPrimary: widget.dataToGoUploadScreen.isPrimary,
                      ),
                    ),
                    BlocBuilder<DownloadUploadBloc, DownloadUploadState>(
                      builder: (context, state) {
                        if (state.updateDataAfterUploadState ==
                            RequestStates.loaded) {
                          return WaitView(
                            isPrimary: widget.dataToGoUploadScreen.isPrimary,
                          );
                        } else {
                          return (widget.dataToGoUploadScreen.examEntity.result
                                  .reupload)
                              ? UploadView(
                                  fileName: widget
                                      .dataToGoUploadScreen.examEntity.name,
                                  fileUrl: widget
                                      .dataToGoUploadScreen.examEntity.file,
                                  isPrimary:
                                      widget.dataToGoUploadScreen.isPrimary,
                                  description: widget.dataToGoUploadScreen
                                          .examEntity.result.description ??
                                      [],
                                )
                              : widget.dataToGoUploadScreen.examEntity.result
                                          .isMark ==
                                      "yes"
                                  ? DegreeView(
                                      degree: widget.dataToGoUploadScreen
                                          .examEntity.result.degree,
                                      totalPoints: widget.dataToGoUploadScreen
                                          .examEntity.degree,
                                      isPrimary:
                                          widget.dataToGoUploadScreen.isPrimary,
                                      description: widget.dataToGoUploadScreen
                                          .examEntity.result.description,
                                      childLevel: widget.dataToGoUploadScreen
                                          .examEntity.result.childLevel,
                                    )
                                  : WaitView(
                                      isPrimary:
                                          widget.dataToGoUploadScreen.isPrimary,
                                    );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ).paddingBody(),
          if (context.mounted)
            ConfettiBottom(
                controller: context
                    .read<DownloadUploadBloc>()
                    ._confettiControllerBottom),
          if (context.mounted)
            ConfettiCenter(
                controller: context
                    .read<DownloadUploadBloc>()
                    ._confettiControllerCenter),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.dataToGoUploadScreen.examEntity.degree ==
            widget.dataToGoUploadScreen.examEntity.result.degree &&
        widget.dataToGoUploadScreen.examEntity.result.isMark == 'yes') {
      context.read<DownloadUploadBloc>().add(const PlayConfettiEvent());
    }
  }
}
