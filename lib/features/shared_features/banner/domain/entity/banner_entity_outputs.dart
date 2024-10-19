import 'package:equatable/equatable.dart';

class BannerEntityOutputs extends Equatable {
  final String? text;
  final String? img;
  final String? coupon;
  final String? expiryDate;
  final String? type;
  const BannerEntityOutputs( {
     this.text,
     this.img,
     this.coupon,
     this.expiryDate,
     this.type,
  });

  BannerEntityOutputs copyWith({
     String? text,
     String? img,
     String? coupon,
     String? expiryDate,
     String? type,
  }) {
    return BannerEntityOutputs(
      text: text ?? this.text,
      img: img ?? this.img,
      coupon: coupon ?? this.coupon,
      expiryDate: expiryDate ?? this.expiryDate,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    text,
    img,
    coupon,
    expiryDate,
    type,];
}
