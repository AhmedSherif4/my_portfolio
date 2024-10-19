part of '../../add_child.dart';


@LazySingleton()
class InstitutionAddChildUseCase
    extends BaseUseCase<String, InstitutionAddChildParameter> {
  final InstitutionAddChildRepository repository;

  InstitutionAddChildUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(InstitutionAddChildParameter parameter) {
    return repository.institutionAddChild(addChildParameter: parameter);
  }
}

class InstitutionAddChildParameter extends Equatable {
  final String name;
  final String emailOrPhone;
  final String phone;
  final SendType sendType;
  final String gendar;
  final String img;
  final String password;
  final int parentId;
  final int systemId;
  final int stageId;
  final int classroomId;
  final int termId;
  final int pathId;

  const InstitutionAddChildParameter({
    required this.parentId,
    required this.systemId,
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.sendType,
    required this.password,
    required this.name,
    required this.emailOrPhone,
    required this.phone,
    required this.gendar,
    required this.img ,
    required this.pathId,
  });



  @override
  List<Object?> get props => [
        name,
        emailOrPhone,
        sendType,
        gendar,
        img,
        password,
        parentId,
        systemId,
        stageId,
        classroomId,
        termId,
        pathId,
        phone
      ];


}
