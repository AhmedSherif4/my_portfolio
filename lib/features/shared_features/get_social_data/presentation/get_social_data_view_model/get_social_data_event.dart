
import 'package:equatable/equatable.dart';

abstract class GetSocialDataEvent extends Equatable {
  const GetSocialDataEvent();
}

class GetGoogleDataEvent extends GetSocialDataEvent {
  @override
  List<Object?> get props => [];
}

class GetAppleDataEvent extends GetSocialDataEvent {
  @override
  List<Object?> get props => [];
}
