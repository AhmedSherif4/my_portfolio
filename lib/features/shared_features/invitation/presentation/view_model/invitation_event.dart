import 'package:equatable/equatable.dart';

abstract class InvitationEvent extends Equatable{}

class GetInvitationEvent extends InvitationEvent {
  final String username;
  GetInvitationEvent(this.username);
  @override
  List<Object> get props => [];
}
