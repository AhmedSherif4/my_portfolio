part of '../../download_upload.dart';

class DownloadUploadState extends Equatable {


  final RequestStates uploadFileStates;
  final String uploadFileErrorMessage;
  final String uploadFileSuccessMessage;

  final RequestStates pickFileStates;
  final String pickFileErrorMessage;
  final File? pickedFile;

  final RequestStates updateDataAfterUploadState;
  final String updateDataAfterUploadErrorMessage;

  final String percentage;

  const DownloadUploadState({

    this.uploadFileStates = RequestStates.initial,
    this.uploadFileErrorMessage = '',
    this.uploadFileSuccessMessage = '',
    this.pickedFile,
    this.pickFileStates = RequestStates.initial,
    this.pickFileErrorMessage = '',
    this.percentage = '',
    this.updateDataAfterUploadState = RequestStates.initial,
    this.updateDataAfterUploadErrorMessage = '',
  });

  DownloadUploadState copyWith({

    RequestStates? uploadFileStates,
    String? uploadFileErrorMessage,
    String? uploadFileSuccessMessage,
    RequestStates? pickFileStates,
    String? pickFileErrorMessage,
    File? pickedFile,
    String? percentage,
    RequestStates? updateDataAfterUploadState,
    String? updateDataAfterUploadErrorMessage,
  }) {
    return DownloadUploadState(

      uploadFileStates: uploadFileStates ?? RequestStates.initial,
      uploadFileErrorMessage:
          uploadFileErrorMessage ?? this.uploadFileErrorMessage,
      uploadFileSuccessMessage:
          uploadFileSuccessMessage ?? this.uploadFileSuccessMessage,
      pickedFile: pickedFile ?? this.pickedFile,
      pickFileStates: pickFileStates ?? RequestStates.initial,
      pickFileErrorMessage: pickFileErrorMessage ?? this.pickFileErrorMessage,
      percentage: percentage ?? this.percentage,
      updateDataAfterUploadState:
          updateDataAfterUploadState ?? RequestStates.initial,
      updateDataAfterUploadErrorMessage: updateDataAfterUploadErrorMessage ??
          this.updateDataAfterUploadErrorMessage,
    );
  }

  @override
  List<Object?> get props => [

        uploadFileStates,
        uploadFileErrorMessage,
        uploadFileSuccessMessage,
        pickedFile,
        pickFileStates,
        pickFileErrorMessage,
        percentage,
        updateDataAfterUploadState,
        updateDataAfterUploadErrorMessage,

      ];
}
