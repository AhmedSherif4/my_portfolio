import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'contact_us_entity.g.dart';

@HiveType(typeId: 13)
class ContactUsEntity extends Equatable {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String facebook;
  @HiveField(2)
  final String? instagram;
  @HiveField(3)
  final String? twitter;
  @HiveField(4)
  final String? linkedIn;
  @HiveField(5)
  final String? snapchat;
  @HiveField(6)
  final String? pinterest;
  @HiveField(7)
  final String? tiktok;
  @HiveField(8)
  final String? threads;
  @HiveField(9)
  final String? youtube;
  @HiveField(10)
  final String? telegram;
  @HiveField(11)
  final String whatsapp;
  @HiveField(12)
  final String messageForParentAfterAddFirstChild;
  @HiveField(13)
  final String messageForParentAfterAddSecondChild;

  const ContactUsEntity({
    required this.email,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.linkedIn,
    required this.snapchat,
    required this.pinterest,
    required this.tiktok,
    required this.threads,
    required this.youtube,
    required this.telegram,
    required this.whatsapp,
    required this.messageForParentAfterAddFirstChild,
    required this.messageForParentAfterAddSecondChild,
  });

  @override
  List<Object?> get props => [
        email,
        facebook,
        instagram,
        twitter,
        linkedIn,
        snapchat,
        pinterest,
        tiktok,
        threads,
        youtube,
        telegram,
        whatsapp,
        messageForParentAfterAddFirstChild,
        messageForParentAfterAddSecondChild,
      ];
}
