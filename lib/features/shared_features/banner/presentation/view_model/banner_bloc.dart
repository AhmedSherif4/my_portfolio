import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/enum/enum_generation.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/usecase/get_banner_usecase.dart';
import 'package:my_portfolio/features/shared_features/banner/presentation/view_model/banner_event.dart';
import 'package:my_portfolio/features/shared_features/banner/presentation/view_model/banner_state.dart';


@Injectable()
class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBannerUseCase _getBannerUseCase;


  BannerBloc(this._getBannerUseCase)
      : super(const BannerState()) {
    on<GetBannerEvent>(_getBanner);}

  void _getBanner(GetBannerEvent event, Emitter<BannerState> emit) async {
    emit(state.copyWith(
        bannerState: RequestStates.loading,));
    final result = await _getBannerUseCase(const NoParameter());
    result.fold(
      (l) => emit(state.copyWith(
        bannerState: RequestStates.error,
        bannerMessage: l.message.toString(),
      )),
      (r) => emit(
        state.copyWith(
          bannerState: RequestStates.loaded,
          banner: r,
        ),
      ),
    );
  }
}
