part of 'contact_us_bloc.dart';

class ContactUsState extends Equatable {
  final RequestStates getContactUsStates;
  final String getContactUsMessage;
  final ContactUsEntity? getContactUsData;

  const ContactUsState({
    this.getContactUsStates = RequestStates.initial,
    this.getContactUsMessage = '',
    this.getContactUsData,
  });

  ContactUsState copyWith({
    RequestStates? getContactUsStates,
    String? getContactUsMessage,
    ContactUsEntity? getContactUsData,
  }) {
    return ContactUsState(
      getContactUsMessage: getContactUsMessage ?? this.getContactUsMessage,
      getContactUsStates: getContactUsStates ?? this.getContactUsStates,
      getContactUsData: getContactUsData ?? this.getContactUsData,
    );
  }

  @override
  List<Object?> get props => [
        getContactUsStates,
        getContactUsMessage,
        getContactUsData,
      ];
}
