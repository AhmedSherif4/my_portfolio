part of '../../un_link.dart';


@LazySingleton()
class UnLinkUseCase extends BaseUseCase<String, int> {
  final UnLinkRepository repository;

  UnLinkUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(int parameter) async {
    return await repository.userUnLink(userId: parameter);
  }
}
