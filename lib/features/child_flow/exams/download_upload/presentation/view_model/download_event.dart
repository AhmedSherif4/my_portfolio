import 'package:equatable/equatable.dart';

abstract class DownloadEvent extends Equatable {}

class DownloadFileEvent extends DownloadEvent {
  final String fileUrl;
  final String fileName;

   DownloadFileEvent({
    required this.fileUrl,
    required this.fileName,
  });

  @override
  List<Object> get props => [fileUrl, fileName];
}

