import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/shared_features/contact_us/domain/contact_us_usecases/contact_us_usecase.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../../domain/entity/contact_us_entity.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

@Injectable()
class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final GetContactUsUseCase getContactUsUseCase;

  ContactUsBloc(this.getContactUsUseCase) : super(const ContactUsState()) {
    on<GetContactUsEvent>(_getContactUs);
  }

  void _getContactUs(
      GetContactUsEvent event, Emitter<ContactUsState> emit) async {
    emit(state.copyWith(
      getContactUsStates: RequestStates.loading,
    ));
    final result = await getContactUsUseCase(const NoParameter());
    result.fold(
      (failure) => emit(state.copyWith(
        getContactUsStates: RequestStates.error,
        getContactUsMessage: failure.message,
      )),
      (success) => emit(state.copyWith(
        getContactUsStates: RequestStates.loaded,
        getContactUsData: success,
      )),
    );
  }
}
