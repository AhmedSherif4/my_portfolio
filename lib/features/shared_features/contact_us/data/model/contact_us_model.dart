import '../../domain/entity/contact_us_entity.dart';

class ContactUsModel extends ContactUsEntity {
  const ContactUsModel(
      {required super.email,
      required super.facebook,
      required super.instagram,
      required super.twitter,
      required super.linkedIn,
      required super.snapchat,
      required super.pinterest,
      required super.tiktok,
      required super.threads,
      required super.youtube,
      required super.telegram,
      required super.whatsapp,
      required super.messageForParentAfterAddFirstChild,
      required super.messageForParentAfterAddSecondChild});

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      email: json['email'] ?? '',
      facebook: json['facebook'] ?? '',
      instagram: json['instagram'] ?? '',
      twitter: json['twitter'] ?? '',
      linkedIn: json['linkedIn'] ?? '',
      snapchat: json['snapchat'] ?? '',
      pinterest: json['pinterest'] ?? '',
      tiktok: json['tiktok'] ?? '',
      threads: json['threads'] ?? '',
      youtube: json['youtube'] ?? '',
      telegram: json['telegram'] ?? '',
      whatsapp: json['whatsapp'] ?? '',
      messageForParentAfterAddFirstChild: json['message_child_2'] ?? '',
      messageForParentAfterAddSecondChild: json['message_child_3'] ?? '',
    );
  }
}
