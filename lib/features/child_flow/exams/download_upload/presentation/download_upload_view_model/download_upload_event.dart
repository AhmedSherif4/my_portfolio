part of '../../download_upload.dart';

abstract class DownloadUploadEvent extends Equatable {
  const DownloadUploadEvent();

  @override
  List<Object> get props => [];
}


class UploadFileEvent extends DownloadUploadEvent {
  final UploadParameters parameters;

  const UploadFileEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}

class PickPDFEvent extends DownloadUploadEvent {
  const PickPDFEvent();

  @override
  List<Object> get props => [];
}

class UpdateDataAfterUploadEvent extends DownloadUploadEvent {
  final UploadParameters parameters;

  const UpdateDataAfterUploadEvent({required this.parameters});

  @override
  List<Object> get props => [parameters];
}

class PlayConfettiEvent extends DownloadUploadEvent {
  const PlayConfettiEvent();

  @override
  List<Object> get props => [];
}

class ProgressUpdateStreamEvent extends DownloadUploadEvent {
  const ProgressUpdateStreamEvent();

  @override
  List<Object> get props => [];
}
