import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/enum/enum_generation.dart';
import '../../download_upload.dart';
import 'download_event.dart';
import 'download_state.dart';

@Injectable()
class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadUseCase downloadUseCase;

  DownloadBloc(
    this.downloadUseCase,
  ) : super(const DownloadState()) {
    on<DownloadFileEvent>(_onDownloadFileEvent);
  }

  StreamController<int>? _progressController;

  StreamController<int> get progressController {
    _progressController ??= StreamController<int>();
    return _progressController!;
  }

  StreamController<TaskProgressUpdate>? _taskProgressUpdateController;

  StreamController<TaskProgressUpdate> get taskProgressUpdateController {
    _taskProgressUpdateController ??= StreamController<TaskProgressUpdate>();
    return _taskProgressUpdateController!;
  }

  FutureOr<void> _onDownloadFileEvent(
      DownloadFileEvent event, Emitter<DownloadState> emit) async {
    _progressController?.close();
    _progressController = null;
    _progressController = StreamController<int>();
    progressController.add(0);
    _taskProgressUpdateController?.close();
    _taskProgressUpdateController = null;
    _taskProgressUpdateController = StreamController<TaskProgressUpdate>();
    emit(state.copyWith(
      downloadFileStates: RequestStates.loading,
    ));
    final result = await downloadUseCase(
      DownloadParameters(
        fileUrl: event.fileUrl,
        fileName: event.fileName,
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          progressController
              .add(int.tryParse((received / total * 100).toStringAsFixed(0))!);
        },
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
        downloadFileStates: RequestStates.error,
        downloadFileMessage: failure.message,
      )),
      (successMessage) {
        emit(
          state.copyWith(
            downloadFileStates: RequestStates.loaded,
            downloadFileMessage: successMessage,
          ),
        );
      },
    );

    await _progressController!.close();
  }
}
