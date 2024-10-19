part of '../home_layout.dart';


@Injectable()
class HomeLayoutBloc extends Bloc<HomeLayoutEvent, HomeLayoutState> {
  HomeLayoutBloc() : super(const HomeLayoutState()) {
    on<ChangeBottomNavBarIndexEvent>(_changeBottomNavBar);
    on<GetUserTypeEvent>(_checkUserTypeToGetFlow);
  }

  List<Widget> childFlow(inReview) => [
        const AllChildHomeScreen(),
        const ChildStaticsScreen(),
          inReview == true ? const NewSubscriptionsScreen() : const SubFLow(),
        const QuranScreen(),
        const ChildMoreScreen(),
      ];

  List<Widget> parentFlow = const [
    ParentHomeScreen(),
    QuranScreen(),
    ChildMoreScreen(),
  ];

  List<Widget> institutionFlow = const [
    InstitutionHomeScreen(),
    QuranScreen(),
    ChildMoreScreen(),
  ];

  void _checkUserTypeToGetFlow(
      GetUserTypeEvent event, Emitter<HomeLayoutState> emit) {
    switch (event.userType) {
      case AppKeys.childKey:
        emit(state.copyWithState(
            appFlowState: HomeLayoutStatesEnum.appFlowState,
            userType: UsersType.child,
            appFlow: childFlow(event.inReview)));
      case AppKeys.parentKey:
        emit(
          state.copyWithState(
            appFlowState: HomeLayoutStatesEnum.appFlowState,
            appFlow: parentFlow,
            userType: UsersType.parent,
          ),
        );
      case AppKeys.institutionKey:
        emit(
          state.copyWithState(
            appFlowState: HomeLayoutStatesEnum.appFlowState,
            appFlow: institutionFlow,
            userType: UsersType.institution,
          ),
        );
      default:
        emit(state.copyWithState(
            appFlowState: HomeLayoutStatesEnum.appFlowState, appFlow: []));
    }
  }

  void _changeBottomNavBar(
      ChangeBottomNavBarIndexEvent event, Emitter<HomeLayoutState> emit) async {
    emit(
      state.copyWithState(
        bottomNavState: HomeLayoutStatesEnum.changeBottomNavState,
        index: event.index,
      ),
    );
  }
}
