import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import '../entity/add_delete_subject_entity.dart';
import '../entity/subject_subscriptions_entity.dart';


abstract class SubjectSubscriptionRepository{
  Future<Either<Failure, AddAndDeleteSubjectEntity>> addSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<Either<Failure, String>> addOptionalSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<Either<Failure, AddAndDeleteSubjectEntity>> deleteSubject({required AddAndDeleteSubjectInputs addAndDeleteSubjectInputs});
  Future<Either<Failure, SubjectSubscriptionsEntity>> getSubjectSubscriptions(SubjectSubscriptionsInputs subjectSubscriptionsInputs);

}