


import 'package:my_portfolio/features/shared_features/banner/domain/entity/banner_entity_outputs.dart';

class BannerModel extends BannerEntityOutputs {
  const BannerModel({
     super.text,
     super.img,
     super.coupon,
     super.expiryDate,
     super.type,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      text: json['text']??"",
      img: json['img']??"",
      coupon: json['coupon']??"",
      expiryDate: json['expiryDate']??"",
      type: json['type']);
  }
}

