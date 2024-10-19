part of '../../un_link.dart';


@LazySingleton()
class ParentAddExistChildUseCase extends BaseUseCase<String, String> {
  final UnLinkRepository repository;

  ParentAddExistChildUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(String parameter) async {
    return await repository.parentAddExistChild(
      username: parameter,
    );
  }
}
