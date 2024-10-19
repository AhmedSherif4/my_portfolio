import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../../../../../config/base_repository/base_repository.dart';
import '../../domain/repository/invitation_repository.dart';
import '../remote_data_source/invitation_remote_data_source.dart';


@LazySingleton(as:InvitationRepository )
class InvitationRepositoryImpl implements InvitationRepository {
  final BaseRepository _baseRepository;
  final GetInvitationRemoteDataSource _remoteDataSource;

  InvitationRepositoryImpl(this._baseRepository, this._remoteDataSource);

  @override
  Future<Either<Failure, String>> getInvitation(String username) async{
    final response =
    await _baseRepository
        .checkExceptionForRemoteData(_remoteDataSource.getInvitation(username));
    return response;
  }
}
