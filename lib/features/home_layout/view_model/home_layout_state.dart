part of '../home_layout.dart';


class HomeLayoutState extends Equatable {
  final HomeLayoutStatesEnum bottomNavState;
  final HomeLayoutStatesEnum appFlowState;
  final List<Widget> appFlow;
  final int index;
  final UsersType userType;

  const HomeLayoutState({
    this.bottomNavState = HomeLayoutStatesEnum.changeBottomNavState,
    this.appFlowState = HomeLayoutStatesEnum.homeLayoutInitState,
    this.appFlow = const [],
    this.index = 0,
    this.userType = UsersType.child,
  });

  HomeLayoutState copyWithState({
    HomeLayoutStatesEnum? bottomNavState,
    HomeLayoutStatesEnum? appFlowState,
    List<Widget>? appFlow,
    int? index,
    final UsersType? userType,
  }) {
    return HomeLayoutState(
      bottomNavState: bottomNavState ?? this.bottomNavState,
      appFlowState: appFlowState ?? this.appFlowState,
      appFlow: appFlow ?? this.appFlow,
      index: index ?? this.index,
      userType: userType ?? this.userType,
    );
  }

  @override
  List<Object?> get props => [
        bottomNavState,
        index,
        appFlowState,
        appFlow,
        userType,
      ];
}
