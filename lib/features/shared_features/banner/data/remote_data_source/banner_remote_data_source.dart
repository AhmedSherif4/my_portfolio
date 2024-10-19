import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/api/end_points.dart';
import 'package:my_portfolio/features/shared_features/banner/data/model/banner_model.dart';
import 'package:my_portfolio/features/shared_features/banner/domain/entity/banner_entity_outputs.dart';
import '../../../../../../config/base_remote_data_source/base_remote_data_source.dart';


abstract class GetBannerRemoteDataSource {
  Future<BannerEntityOutputs?> getBanner();
}

@LazySingleton(as: GetBannerRemoteDataSource)
class GetBannerRemoteDataSourceImpl implements GetBannerRemoteDataSource {
  final BaseRemoteDataSource _dataSource;

  GetBannerRemoteDataSourceImpl(this._dataSource);
  @override
  Future<BannerEntityOutputs?> getBanner()async{

    final response = await _dataSource.postData(
        url:   EndPoints.bannerPath,
      body: {}
       );
    if(response['data'] == null) {
      return null;
    }

    return  BannerModel.fromJson(response['data']);

  }
}
