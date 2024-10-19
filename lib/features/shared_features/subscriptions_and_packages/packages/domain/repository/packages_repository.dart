import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/failure/failure.dart';
import '../../data/model/add_classroom_model.dart';

abstract class PackagesRepository {
  Future<Either<Failure, AddClassroomModelHaveTermsAndOptionalSubjects>> addClassroomToCart(
      {required AddItemToCartParameters addItemToCartParameters });
  Future<Either<Failure,  AddTermModelHaveOptionalSubjects>> addTermToCart({required AddItemToCartParameters addItemToCartParameters});
  Future<Either<Failure, String>> addSubjectToCart({required AddItemToCartParameters addItemToCartParameters});
}

class AddItemToCartParameters extends Equatable {
  final int userID;
  final int id;
  final int? pathId;

  const AddItemToCartParameters({required this.userID, required this.id,this.pathId});

  @override
  List<Object?> get props =>[userID, id,pathId];
}
