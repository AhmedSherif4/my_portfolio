import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:my_portfolio/core/failure/failure.dart';



abstract class InvitationRepository{
  Future<Either<Failure, String>> getInvitation(String username);
}

