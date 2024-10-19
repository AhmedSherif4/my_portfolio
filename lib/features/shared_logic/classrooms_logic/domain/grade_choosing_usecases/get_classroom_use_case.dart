import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../classrooms_logic.dart';
import '../../data/models/studying_model.dart';

@LazySingleton()
class GetClassRoomUseCase extends BaseUseCase<List<StudyingModel>, GetClassRoomParameter> {
  final GradeChoosingBaseRepository repository;

  GetClassRoomUseCase({required this.repository});

  @override
  Future<Either<Failure, List<StudyingModel>>> call(GetClassRoomParameter parameter) async {
    return await repository.getClassRoom(
      getClassRoomParameter: parameter,
    );
  }
}
