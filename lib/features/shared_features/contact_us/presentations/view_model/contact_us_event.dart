part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class GetContactUsEvent extends ContactUsEvent {
  @override
  List<Object?> get props => [];
}
