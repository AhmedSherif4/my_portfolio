import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/features/institution_flow/add_parent_or_child/add_parent/domain/use_case/add_parent_use_case.dart';

import '../../../../../core/enum/enum_generation.dart';

part 'add_parent_event.dart';
part 'add_parent_state.dart';

@Injectable()
class AddParentBloc extends Bloc<AddParentEvent, AddParentState> {
  final AddParentUseCase addParentUseCase;

  AddParentBloc(this.addParentUseCase) : super(const AddParentState()) {
    on<AddNewParentEvent>((event, emit) async {
      emit(state.copyWith(
        addNewParentStates: RequestStates.loading,
      ));
      final result = await addParentUseCase(
        event.addParentParameter,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
              addNewParentStates: RequestStates.error,
              addNewParentMessage: failure.message));
        },
        (success) {
          emit(
            state.copyWith(
              addNewParentStates: RequestStates.loaded,
              addNewParentMessage: success,
            ),
          );
        },
      );
    });
  }
}
