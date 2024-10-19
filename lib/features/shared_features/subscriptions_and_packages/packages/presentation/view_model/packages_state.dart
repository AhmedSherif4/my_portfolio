import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import '../../data/model/add_classroom_model.dart';

class PackagesState extends Equatable {

  final RequestStates addClassroomToCartState;
  final AddClassroomModelHaveTermsAndOptionalSubjects? addClassroomToCartData;
  final String addClassroomToCartMessage;

  final RequestStates addTermToCartState;
  final String addTermToCartMessage;
  final AddTermModelHaveOptionalSubjects? addTermToCartData;

  final RequestStates addSubjectToCartState;
  final String addSubjectToCartMessage;



  const PackagesState({
    this.addClassroomToCartState = RequestStates.initial,
    this.addClassroomToCartData,
    this.addClassroomToCartMessage = '',
    // this.currentClassRoom = const StudyingModel(id: 0, name: 'Loading'),

    this.addTermToCartState = RequestStates.initial,
    this.addTermToCartMessage = '',
    this.addTermToCartData,
    this.addSubjectToCartState = RequestStates.initial,
    this.addSubjectToCartMessage = '',
  });

  PackagesState copyWith({
    RequestStates? addClassroomToCartState,
    AddClassroomModelHaveTermsAndOptionalSubjects? addClassroomToCartData,
    String? addClassroomToCartMessage,
    // StudyingModel? currentClassRoom,

    RequestStates? addTermToCartState,
    String? addTermToCartMessage,
    AddTermModelHaveOptionalSubjects? addTermToCartData,
    RequestStates? addSubjectToCartState,
    String? addSubjectToCartMessage,
  }) {
    return PackagesState(
      addClassroomToCartState: addClassroomToCartState ??
          this.addClassroomToCartState,
      addClassroomToCartData: addClassroomToCartData ??
          this.addClassroomToCartData,
      addClassroomToCartMessage: addClassroomToCartMessage?? this.addClassroomToCartMessage,
      // currentClassRoom: currentClassRoom ?? this.currentClassRoom,

      addTermToCartState: addTermToCartState ?? this.addTermToCartState,
      addTermToCartMessage: addTermToCartMessage ?? this.addTermToCartMessage,
      addTermToCartData: addTermToCartData ?? this.addTermToCartData,
      addSubjectToCartState: addSubjectToCartState ??
          this.addSubjectToCartState,
      addSubjectToCartMessage: addSubjectToCartMessage ??
          this.addSubjectToCartMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        addClassroomToCartState,
        addClassroomToCartMessage,
        addClassroomToCartData,
        addTermToCartState,
        addTermToCartMessage,
        addTermToCartData,
        addSubjectToCartState,
        addSubjectToCartMessage,
      ];
}