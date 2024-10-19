part of '../../download_upload.dart';

@Injectable()
class DownloadUploadBloc
    extends Bloc<DownloadUploadEvent, DownloadUploadState> {
  final UploadUseCase uploadUseCase;
  final ExamsUseCase getExamsUseCase;
  // final ExamsLocalDataSource examsLocalDataSource;


  DownloadUploadBloc(
    this.uploadUseCase,
    this.getExamsUseCase,
      // this.examsLocalDataSource,
      ) : super(const DownloadUploadState()) {
    on<UploadFileEvent>(_onUploadFileEvent);
    on<PickPDFEvent>(_onPickPDFEvent);
    on<PlayConfettiEvent>(_onPlayConfettiEvent);
    on<UpdateDataAfterUploadEvent>(_onUpdateDataAfterUploadEvent);
    _confettiControllerBottom =
        ConfettiController(duration: durationOfConfetti);
    _confettiControllerCenter =
        ConfettiController(duration: durationOfConfetti);
  }

  FutureOr<void> _onUploadFileEvent(
      UploadFileEvent event, Emitter<DownloadUploadState> emit) async {
    emit(state.copyWith(
      uploadFileStates: RequestStates.loading,
      pickFileStates: RequestStates.initial,
    ));
    final result = await uploadUseCase(event.parameters);
    result.fold(
      (failure) => emit(
        state.copyWith(
          uploadFileStates: RequestStates.error,
          uploadFileErrorMessage: failure.message,
          pickFileStates: RequestStates.initial,
        ),
      ),
      (successMessage) async {
        emit(
          state.copyWith(
            uploadFileStates: RequestStates.loaded,
            uploadFileSuccessMessage: successMessage,
            pickFileStates: RequestStates.initial,
            updateDataAfterUploadState: RequestStates.loaded,
          ),
        );
        // getIt.get<ExamsBloc>().add(
        //       GetExamsOfThatSubject(
        //         systemId: 0,
        //         subjectId: event.parameters.subjectId,
        //         stageId: 0,
        //         termId: 0,
        //         pathId: 0,
        //         classroomId: 0,
        //         selectedIndex: 0,
        //       ),
        //     );
      },
    );
  }

  FutureOr<void> _onPickPDFEvent(
      PickPDFEvent event, Emitter<DownloadUploadState> emit) async {
    try {
      await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      ).then((value) {
        emit(
          state.copyWith(
            pickFileStates: RequestStates.loaded,
            pickedFile: File(value!.files.single.path!),
            uploadFileStates: RequestStates.initial,
          ),
        );
      }).onError((error, stackTrace) {
        emit(state.copyWith(
          pickFileStates: RequestStates.error,
          pickFileErrorMessage: AppStrings.youHaveToPickFilePDF,
          uploadFileStates: RequestStates.initial,
        ));
      });
    } catch (e) {
      emit(
        state.copyWith(
          pickFileStates: RequestStates.error,
          pickFileErrorMessage: AppStrings.cantPickTheFile,
          uploadFileStates: RequestStates.initial,
        ),
      );
    }
  }

  FutureOr<void> _onUpdateDataAfterUploadEvent(UpdateDataAfterUploadEvent event,
      Emitter<DownloadUploadState> emit) async {
    // final listOfExamsOfSpecificSubject = await examsLocalDataSource
    //     .getExamsForSpecificSubject(subjectId: event.parameters.exam.subjectId);
    // final ExamEntity updatedExam =
    // listOfExamsOfSpecificSubject![event.parameters.index].copyWith(
    //     result: listOfExamsOfSpecificSubject[event.parameters.index]
    //         .result
    //         .copyWith(reupload: false));
    // examsLocalDataSource.updateExam(
    //   index: event.parameters.index,
    //   subjectId: event.parameters.exam.subjectId,
    //   updatedExam: updatedExam,
    // );
    // emit(state.copyWith(
    //   updateDataAfterUploadState: RequestStates.loaded,
    // ));
  }

  late final ConfettiController _confettiControllerBottom;
  late final ConfettiController _confettiControllerCenter;
  Duration durationOfConfetti = const Duration(seconds: 3);

  FutureOr<void> _onPlayConfettiEvent(
      PlayConfettiEvent event, Emitter<DownloadUploadState> emit) async {
    _confettiControllerBottom.play();
    _confettiControllerCenter.play();
  }

  @override
  Future<void> close() {
    _confettiControllerBottom.removeListener(() {
      _confettiControllerBottom.dispose();
    });
    _confettiControllerCenter.removeListener(() {
      _confettiControllerCenter.dispose();
    });
    return super.close();
  }

}

