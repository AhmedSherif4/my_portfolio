import 'package:dartz/dartz.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/entity/contact_us_entity.dart';

import '../../../../../core/failure/failure.dart';

abstract class ContactUsBaseRepository {
  Future<Either<Failure, ContactUsEntity>> getContacts();
}
