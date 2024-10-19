import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import '../../domain/entity/subject_subscriptions_entity.dart';
import '../../domain/usecase/add_optinal_subject.dart';
import '../../domain/usecase/add_subject.dart';
import '../../domain/usecase/delete_subject.dart';
import '../../domain/usecase/subject_subscription_usecase.dart';
import 'packages_and_subscriptions_event.dart';
import 'packages_and_subscriptions_state.dart';

@Injectable()
class PackagesAndSubscriptionsBloc
    extends Bloc<PackagesAndSubscriptionsEvent, PackagesAndSubscriptionsState> {
  final AddSubjectUseCase _addSubjectUseCase;
  final AddOptionalSubjectUseCase _addOptionalSubjectUsecase;
  final DeleteSubjectUseCase _deleteSubjectUseCase;
  final SubjectSubscriptionsUseCase _getSubjectSubscriptionsUseCase;

  PackagesAndSubscriptionsBloc(
      this._addSubjectUseCase,
      this._addOptionalSubjectUsecase,
      this._deleteSubjectUseCase,
      this._getSubjectSubscriptionsUseCase)
      : super(const PackagesAndSubscriptionsState()) {
    on<AddSubjectToCartEvent>(_addSubjectToCart);
    on<AddOptionalSubjectToCartEvent>(_addOptionalSubjectToCart);
    on<DeleteSubjectFromCartEvent>(_deleteSubjectFromCart);
    on<GetSubjectSubscriptionsDataEvent>(_getSubjectSubscriptions);
    on<AddAdllSubjectsEvent>(addAll);
  }

  void _addSubjectToCart(AddSubjectToCartEvent event,
      Emitter<PackagesAndSubscriptionsState> emit) async {
    emit(state.copyWith(
      addSubjectToCartState: RequestStates.loading,
      addOptionalSubjectToCartState: RequestStates.initial,
      deleteSubjectFromCartState: RequestStates.initial,
      currentTermId: event.addAndDeleteSubjectInputs.termId,
      addAllSubjects: SelectAllState.init,
    ));
    final result = await _addSubjectUseCase(event.addAndDeleteSubjectInputs);
    // event.addAndDeleteSubjectInputs.termId.log();
    emit(state.copyWith(currentTermId: event.addAndDeleteSubjectInputs.termId));
    result.fold(
      (l) => emit(state.copyWith(
        addSubjectToCartState: RequestStates.error,
        addSubjectToCartMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          addSubjectToCartState: RequestStates.loaded,
          addSubjectToCartMessage: r.message,
          subjectSubscriptions: r.subjectSubscriptionsDetails,
        ),
      ),
    );
  }

  void _addOptionalSubjectToCart(AddOptionalSubjectToCartEvent event,
      Emitter<PackagesAndSubscriptionsState> emit) async {
    emit(state.copyWith(
      addOptionalSubjectToCartState: RequestStates.loading,
      addSubjectToCartState: RequestStates.initial,
      deleteSubjectFromCartState: RequestStates.initial,
      addAllSubjects: SelectAllState.init,
    ));
    final result =
        await _addOptionalSubjectUsecase(event.addAndDeleteSubjectInputs);
    result.fold(
      (l) => emit(state.copyWith(
        addOptionalSubjectToCartState: RequestStates.error,
        addOptionalSubjectToCartMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          addOptionalSubjectToCartState: RequestStates.loaded,
          addOptionalSubjectToCartMessage: r,
        ),
      ),
    );
  }

  void _deleteSubjectFromCart(DeleteSubjectFromCartEvent event,
      Emitter<PackagesAndSubscriptionsState> emit) async {
    emit(state.copyWith(
      deleteSubjectFromCartState: RequestStates.loading,
      addOptionalSubjectToCartState: RequestStates.initial,
      addSubjectToCartState: RequestStates.initial,
      addAllSubjects: SelectAllState.init,
    ));
    final result = await _deleteSubjectUseCase(event.addAndDeleteSubjectInputs);
    result.fold(
      (l) => emit(state.copyWith(
        deleteSubjectFromCartState: RequestStates.error,
        deleteSubjectFromCartMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          deleteSubjectFromCartState: RequestStates.loaded,
          deleteSubjectFromCartMessage: r.message,
          subjectSubscriptions: r.subjectSubscriptionsDetails,
        ),
      ),
    );
  }

  void _getSubjectSubscriptions(GetSubjectSubscriptionsDataEvent event,
      Emitter<PackagesAndSubscriptionsState> emit) async {
    emit(state.copyWith(
      subjectSubscriptionsState: RequestStates.loading,
    ));
    final result =
        await _getSubjectSubscriptionsUseCase(event.subjectSubscriptionsInputs);
    result.fold(
      (l) => emit(state.copyWith(
        subjectSubscriptionsState: RequestStates.error,
        subjectSubscriptionsEventMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          subjectSubscriptionsState: RequestStates.loaded,
          subjectSubscriptions: r,
        ),
      ),
    );
  }

  void addAll(AddAdllSubjectsEvent event,
      Emitter<PackagesAndSubscriptionsState> emit) async {
    emit(state.copyWith(
      addAllSubjects: SelectAllState.startSelectAll,
      deleteSubjectFromCartState: RequestStates.initial,
      addOptionalSubjectToCartState: RequestStates.initial,
      addSubjectToCartState: RequestStates.initial,
    ));
    SubjectSubscriptionsEntity subjectSubscriptions =
        state.subjectSubscriptions;

    for (int i =1;  subjectSubscriptions.terms[event.termIndex].subjects.length > i; i++) {
      if (!subjectSubscriptions.terms[event.termIndex].subjects[i].isSubscribed && !subjectSubscriptions.terms[event.termIndex].subjects[i].cart && !subjectSubscriptions.terms[event.termIndex].subjects[i].isFree) {
        final result = await _addSubjectUseCase(
          AddAndDeleteSubjectInputs(
            subjectId: subjectSubscriptions.terms[event.termIndex].subjects[i].subjectID,
            pathId: subjectSubscriptions.terms[event.termIndex].subjects[i].pathID,
            childId: event.childId,
            termId: subjectSubscriptions.terms[event.termIndex].subjects[i].termID,
          ),
        );
        result.fold(
              (l) => null,
              (r) {
            subjectSubscriptions = r.subjectSubscriptionsDetails;
          },
        );


      }
    }
    emit(state.copyWith(
        addAllSubjects: SelectAllState.endSelectAll,
        subjectSubscriptions: subjectSubscriptions));
  }
}

enum SelectAllState { init, startSelectAll, endSelectAll }
