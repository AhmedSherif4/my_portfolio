

import '../../domain/entity/review_entity_outputs.dart';

class ReviewModel extends ReviewEntityOutputs {
  const ReviewModel({
    required super.id,
    required super.childId,
    required super.createdAt,
    required super.updatedAt,
    required super.reviewText,
    required super.starsNum,
    required super.parentId,
    required super.institutionId,
    required super.status,
    required super.isDeleted,
    required super.response,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      childId: json['child_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      reviewText: json['review_text'],
      starsNum: json['stars_num'],
      parentId: json['parent_id'],
      institutionId: json['institution_id'],
      status: json['status'],
      isDeleted: json['is_deleted'],
      response: List.from(json['response']) ,
    );
  }
}

