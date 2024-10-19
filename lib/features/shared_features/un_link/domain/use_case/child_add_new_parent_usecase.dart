part of '../../un_link.dart';


@LazySingleton()
class ChildAddNewParentUseCase extends BaseUseCase<String, String> {
  final UnLinkRepository repository;

  ChildAddNewParentUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(String parameter) async {
    return await repository.childAddNewParent(emailOrPhone: parameter);
  }
}
