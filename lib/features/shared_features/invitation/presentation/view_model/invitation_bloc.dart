import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import '../../domain/usecase/invitation_usecase.dart';
import 'invitation_event.dart';
import 'invitation_state.dart';


@Injectable()
class InvitationBloc extends Bloc<InvitationEvent, InvitationState> {
  final GetInvitationUseCase _getInvitationUseCase;


  InvitationBloc(this._getInvitationUseCase)
      : super(const InvitationState()) {
    on<GetInvitationEvent>(_getInvitation);}

  void _getInvitation(GetInvitationEvent event, Emitter<InvitationState> emit) async {
    emit(state.copyWith(
        invitationState: RequestStates.loading,));
    final result = await _getInvitationUseCase(event.username);
    result.fold(
      (l) => emit(state.copyWith(
        invitationState: RequestStates.error,
        invitationMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          invitationState: RequestStates.loaded,
          invitationMessage: r,
        ),
      ),
    );
  }
}
