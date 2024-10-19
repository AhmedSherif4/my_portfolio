part of '../../download_upload.dart';

abstract class DownloadUploadRemoteDataSource {
  Future<String> downloadFile(DownloadParameters parameters);

  Future<String> uploadFile(UploadParameters parameters);
}

@LazySingleton(as: DownloadUploadRemoteDataSource)
class DownloadUploadRemoteDataSourceImpl
    implements DownloadUploadRemoteDataSource {
  final BaseRemoteDataSource baseRemoteDataSource;

  DownloadUploadRemoteDataSourceImpl({required this.baseRemoteDataSource});

  @override
  Future<String> downloadFile(DownloadParameters parameters) async {
    String? savePath;
    try {
      if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();

        savePath = '${directory.path}${Platform.pathSeparator}';
      } else {
        // savePath = await ExternalPath.getExternalStoragePublicDirectory(
        //     ExternalPath.DIRECTORY_DOWNLOADS);
      }
    } catch (e) {

      throw const ServerException(message: AppStrings.cantAccessToFiles);
    }
    return baseRemoteDataSource.download(
      parameters.fileUrl,
      savePath: '$savePath/exams/${parameters.fileName}.pdf',
      onReceiveProgress: parameters.onReceiveProgress,
    );
  }

  @override
  Future<String> uploadFile(UploadParameters parameters) async {
    final response = await baseRemoteDataSource.postData(
      url: EndPoints.uploadExam,
      body:
      FormData.fromMap({
        'exam_id': parameters.exam.id.toString(),
        'file': MultipartFile.fromFileSync(
          parameters.file.path,
          filename: parameters.file.path.split('/').last,
        ),
      }),
    );
    return response['message'];
  }
}

class UploadParameters extends Equatable {
  final File file;
  final ExamEntity exam;
  final int index;
  final int subjectId;

  const UploadParameters({
    required this.file,
    required this.exam,
    required this.index,
    required this.subjectId ,
  });

  UploadParameters copyWith({
    File? file,
    ExamEntity? exam,
    int? index,
    int? subjectId,
  }){
    return UploadParameters(
      file: file ?? this.file,
      exam: exam ?? this.exam,
      index: index ?? this.index,
      subjectId: subjectId ?? this.subjectId,
    );
  }
  @override
  List<Object> get props => [
        file,
        exam,
        index,
        subjectId,
      ];
}

class DownloadParameters extends Equatable {
  final String fileUrl;
  final String fileName;
  final void Function(int, int)? onReceiveProgress;

  const DownloadParameters({
    required this.fileUrl,
    required this.fileName,
    this.onReceiveProgress,
  });

  @override
  List<Object?> get props => [
        fileUrl,
        fileName,
        onReceiveProgress,
      ];
}
