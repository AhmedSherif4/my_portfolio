part of '../../download_upload.dart';

@LazySingleton(as: DownloadUploadBaseRepository)
class DownloadUploadRepository implements DownloadUploadBaseRepository {
  final DownloadUploadRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;

  DownloadUploadRepository({
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, String>> downloadFile(
      DownloadParameters parameters) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.downloadFile(parameters),
    );
  }

  @override
  Future<Either<Failure, String>> uploadFile(
      UploadParameters parameters) async {
    return await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.uploadFile(parameters),
    );
  }
}
