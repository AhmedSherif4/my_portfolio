import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/contact_us/data/contact_us_data_source/contact_us_local_data_sourcec.dart';
import 'package:my_portfolio/features/shared_features/contact_us/data/contact_us_data_source/contact_us_remote_data_source.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/contact_us_base_repository/contact_us_base_repository.dart';

import '../../../../../config/base_repository/base_repository.dart';
import '../../../../../core/failure/failure.dart';
import '../../domain/entity/contact_us_entity.dart';

@LazySingleton(
  as: ContactUsBaseRepository,
)
class ContactUsRepository implements ContactUsBaseRepository {
  final ContactUsRemoteDataSource remoteDataSource;
  final BaseRepository baseRepository;
  final GetContactUsLocalDataSource localDataSource;

  ContactUsRepository({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.baseRepository,
  });

  @override
  Future<Either<Failure, ContactUsEntity>> getContacts() async {
    final contactUs = await localDataSource.getContactUs();
    if (contactUs != null) {
      return Right(contactUs);
    }
    final jsonData = await baseRepository.checkExceptionForRemoteData(
      remoteDataSource.getContactUs(),
    );
    return jsonData.fold(
      (failure) => left(failure),
      (data) async {

        await localDataSource.saveContactUs(data: data);
        return Right(data);
      },
    );
  }
}
