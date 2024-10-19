import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/enum/enum_generation.dart';
import '../../../../child_flow/home/home.dart';
import 'subscriptions_and_packages_subjects_event.dart';
import 'subscriptions_and_packages_subjects_state.dart';

@Injectable()
class SubscriptionsAndPackagesSubjectsBloc extends Bloc<SubscriptionsAndPackagesSubjectsEvent, SubscriptionsAndPackagesSubjectsState> {

  final GetSubjectsUseCase getSubjects;

  SubscriptionsAndPackagesSubjectsBloc(this.getSubjects) : super(const SubscriptionsAndPackagesSubjectsState()) {
    on<GetSubscriptionsAndPackagesSubjectsEvent>(_onGotSubjects);
  }

  FutureOr<void> _onGotSubjects(
      GetSubscriptionsAndPackagesSubjectsEvent event, Emitter<SubscriptionsAndPackagesSubjectsState> emit) async {
    emit(
      state.copyWith(
        subjectsStates: RequestStates.loading,
      ),
    );
    final result = await getSubjects(event.subjectsParameters);

    result.fold((failure) {
      emit(
        state.copyWith(
          subjectsStates: RequestStates.error,
          subjectsErrorMessage: failure.message,
        ),
      );
    }, (subjects) {
      emit(state.copyWith(
        subjectsStates: RequestStates.loaded,
        subjects: subjects,
      ));
    });
  }

}
