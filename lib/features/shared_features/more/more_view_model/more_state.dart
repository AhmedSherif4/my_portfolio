import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';

class MoreState extends Equatable {
  final RequestStates logoutState;
  final RequestStates reOpenState;

  final RequestStates getScreenState;
  final FormattedAppState formattedAppState;
  final List<String> childScreens;
  final List<String> parentScreens;

  const MoreState({
    this.logoutState = RequestStates.initial,
    this.reOpenState = RequestStates.initial,
    this.getScreenState = RequestStates.initial,
    this.formattedAppState = FormattedAppState.initial,
    this.childScreens = const [],
    this.parentScreens = const [],
  });

  MoreState copyWith({
    RequestStates? logoutState,
    RequestStates? reOpenState,
    RequestStates? getScreenState,
    List<String>? childScreens,
    List<String>? parentScreens,
    FormattedAppState? formattedAppState
  }) {
    return MoreState(
      logoutState: logoutState ?? this.logoutState,
      reOpenState: reOpenState ?? this.reOpenState,
      getScreenState: getScreenState ?? this.getScreenState,
      childScreens: childScreens ?? this.childScreens,
      parentScreens: parentScreens ?? this.parentScreens,
      formattedAppState: formattedAppState ?? this.formattedAppState,
    );
  }

  @override
  List<Object?> get props => [
        logoutState,
        reOpenState,
        getScreenState,
        childScreens,
        parentScreens,
        formattedAppState
      ];
}
