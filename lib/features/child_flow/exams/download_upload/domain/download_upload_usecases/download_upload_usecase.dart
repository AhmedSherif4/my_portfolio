part of '../../download_upload.dart';

@LazySingleton()
class DownloadUseCase extends BaseUseCase<String, DownloadParameters> {
  final DownloadUploadBaseRepository repository;

  DownloadUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(DownloadParameters parameter) async {
    return await repository.downloadFile(
      parameter,
    );
  }
}

@LazySingleton()
class UploadUseCase extends BaseUseCase<String, UploadParameters> {
  final DownloadUploadBaseRepository repository;

  UploadUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(UploadParameters parameter) async {
    return await repository.uploadFile(
      parameter,
    );
  }
}
