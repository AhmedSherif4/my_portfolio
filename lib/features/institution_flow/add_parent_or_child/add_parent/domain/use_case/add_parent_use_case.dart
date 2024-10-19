import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/repository/add_parent_repositoty.dart';

import '../../../../../../core/enum/enum_generation.dart';
import '../../../../../../core/failure/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';

@LazySingleton()
class AddParentUseCase extends BaseUseCase<String, AddParentParameter> {
  final AddParentRepository repository;

  AddParentUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(AddParentParameter parameter) {
    return repository.addNewParent(addParentParameter: parameter);
  }
}

class AddParentParameter extends Equatable {
  final String name;
  final String emailOrPhone;
  final SendType sendType;
  final String gendar;
  final String img;
  final String password;

  const AddParentParameter({
    required this.sendType,
    required this.password,
    required this.name,
    required this.emailOrPhone,
    required this.gendar,
    this.img = '',
  });

  @override
  List<Object> get props => [
        name,
        emailOrPhone,
        sendType,
        gendar,
        img,
        password,
      ];
}
