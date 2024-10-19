part of '../../un_link.dart';


@LazySingleton()
class ParentAddNewChildUseCase extends BaseUseCase<String, String> {
  final UnLinkRepository repository;

  ParentAddNewChildUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(parameter) async {
    return await repository.parentAddNewChild(mailOrPhone: parameter);
  }
}
