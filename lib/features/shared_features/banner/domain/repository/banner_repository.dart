import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/entity/banner_entity_outputs.dart';



abstract class BannerRepository{
  Future<Either<Failure, BannerEntityOutputs?>> getBanner();
}

