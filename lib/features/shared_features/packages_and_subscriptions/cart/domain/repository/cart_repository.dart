import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';

import '../entity/cart_entity.dart';

abstract class CartRepository{
  Future<Either<Failure, CartEntity>> viewCartData(int childId);

  Future<Either<Failure, String>> deleteAllDataInCart(int childId);

}