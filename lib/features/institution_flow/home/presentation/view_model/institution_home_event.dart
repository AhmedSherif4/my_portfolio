part of 'institution_home_bloc.dart';

abstract class InstitutionHomeEvent extends Equatable {
  const InstitutionHomeEvent();
}

class GetAllParentsForInstitutionEvent extends InstitutionHomeEvent {
  @override
  List<Object?> get props => [];
}
