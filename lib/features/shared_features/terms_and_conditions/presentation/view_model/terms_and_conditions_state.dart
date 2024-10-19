part of '../../terms_and_conditions.dart';


class TermsAndConditionsState extends Equatable {
  final RequestStates getTermsAndConditionsStates;
  final String getTermsAndConditionsMessage;
  final TermsAndConditionsEntity getTermsAndConditionsData;

  const TermsAndConditionsState({
    this.getTermsAndConditionsStates = RequestStates.initial,
    this.getTermsAndConditionsMessage = '',
    this.getTermsAndConditionsData = const TermsAndConditionsEntity(
      title: '',
      content: '',
    ),
  });


  TermsAndConditionsState copyWith({
    RequestStates? getTermsAndConditionsStates,
    String? getTermsAndConditionsMessage,
    TermsAndConditionsEntity? getTermsAndConditionsData,
  }) {
    return TermsAndConditionsState(
      getTermsAndConditionsMessage:
      getTermsAndConditionsMessage ?? this.getTermsAndConditionsMessage,
      getTermsAndConditionsStates:
      getTermsAndConditionsStates ?? this.getTermsAndConditionsStates,
      getTermsAndConditionsData:
      getTermsAndConditionsData ?? this.getTermsAndConditionsData,
    );
  }

  @override
  List<Object> get props =>
      [
        getTermsAndConditionsStates,
        getTermsAndConditionsMessage,
        getTermsAndConditionsData,
      ];
}
