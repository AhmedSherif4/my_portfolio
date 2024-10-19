part of '../../un_link.dart';


@LazySingleton()
class ChildAddExistParentScreenUseCase extends BaseUseCase<String, String> {
  final UnLinkRepository repository;

  ChildAddExistParentScreenUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(String parameter) async {
    return await repository.childAddExistParent(
      username: parameter,
    );
  }
}
