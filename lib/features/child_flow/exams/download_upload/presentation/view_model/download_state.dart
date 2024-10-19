
import 'package:equatable/equatable.dart';

import '../../../../../../core/enum/enum_generation.dart';

class DownloadState extends Equatable {
  final RequestStates downloadFileStates;

  final String downloadFileMessage;

  const DownloadState({
    this.downloadFileStates = RequestStates.initial,
    this.downloadFileMessage = '',
  });

  DownloadState copyWith({
    RequestStates? downloadFileStates,
    String? downloadFileMessage,
  }) {
    return DownloadState(
      downloadFileStates: downloadFileStates ?? RequestStates.initial,
      downloadFileMessage:
          downloadFileMessage ?? this.downloadFileMessage,
    );
  }

  @override
  List<Object?> get props => [
        downloadFileStates,
        downloadFileMessage,
      ];
}
