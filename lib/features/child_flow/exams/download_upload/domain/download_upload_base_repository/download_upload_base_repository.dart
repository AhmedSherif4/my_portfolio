part of '../../download_upload.dart';

abstract class DownloadUploadBaseRepository {
  Future<Either<Failure, String>> downloadFile(DownloadParameters parameters);
  Future<Either<Failure, String>> uploadFile(UploadParameters parameters);
}
