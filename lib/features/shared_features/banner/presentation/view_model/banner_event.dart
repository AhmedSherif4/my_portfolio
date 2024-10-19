import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable{}

class GetBannerEvent extends BannerEvent {
  GetBannerEvent();
  @override
  List<Object> get props => [];
}
