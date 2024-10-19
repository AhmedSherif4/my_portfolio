import 'package:equatable/equatable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/entity/banner_entity_outputs.dart';

class BannerState extends Equatable {
  final RequestStates bannerState;
  final BannerEntityOutputs banner;
  final String bannerMessage;


  const BannerState({
    this.bannerState = RequestStates.initial,
    this.banner = const BannerEntityOutputs(text: '', img: '', coupon: '', expiryDate: '', type: ''),
    this.bannerMessage = '',
  });

  BannerState copyWith({
     RequestStates? bannerState,
     BannerEntityOutputs? banner,
     String? bannerMessage,
  }) {
    return BannerState(
      bannerState: bannerState ?? this.bannerState,
      banner: banner ?? this.banner,
      bannerMessage: bannerMessage ?? this.bannerMessage,
    );
  }

  @override
  List<Object?> get props => [
        bannerState,
        banner,
        bannerMessage,
      ];
}
