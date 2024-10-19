part of '../../terms_and_conditions.dart';


class TermsAndConditionsModel extends TermsAndConditionsEntity {
  const TermsAndConditionsModel({
    required super.title,
    required super.content,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsAndConditionsModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
