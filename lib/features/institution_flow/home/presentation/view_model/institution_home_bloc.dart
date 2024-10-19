import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/institution_flow/home/domain/use_case/institution_use_case.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/shared_models/user/user_entity/user_entity.dart';
import '../../../../../core/usecase/base_usecase.dart';

part 'institution_home_event.dart';
part 'institution_home_state.dart';

@Injectable()
class InstitutionHomeBloc
    extends Bloc<InstitutionHomeEvent, InstitutionHomeState> {
  List<UserEntity> allParents = [];
  final GetAllParentsForInstitutionUseCase getAllParentsForInstitutionUseCase;
  InstitutionHomeBloc(this.getAllParentsForInstitutionUseCase)
      : super(const InstitutionHomeState()) {
    on<GetAllParentsForInstitutionEvent>((event, emit) async {
      emit(state.copyWith(allParentsState: RequestStates.loading));
      final result =
          await getAllParentsForInstitutionUseCase(const NoParameter());

      result.fold(
        (l) => emit(state.copyWith(
            allParentsState: RequestStates.error,
            allParentsErrorMessage: l.message.toString())),
        (r) { emit(state.copyWith(
            allParentsState: RequestStates.loaded,
            allParents: r));
          allParents = r;
        }
      );
    });
  }
}
