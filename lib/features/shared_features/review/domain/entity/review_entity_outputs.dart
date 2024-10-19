import 'package:equatable/equatable.dart';

class ReviewEntityOutputs extends Equatable {
  final int id;
  final int? childId;
  final int? parentId;
  final int? institutionId;
  final String? reviewText;
  final int? starsNum;
  final String? status;
  final String? isDeleted;
  final String? updatedAt;
  final String? createdAt;
  final List<String>? response;





  const ReviewEntityOutputs( {
    required this.id, required this.childId, required this.reviewText, required this.starsNum, required this.updatedAt, required this.createdAt,
    required this.parentId, required this.institutionId, required this.status, required this.isDeleted, required this.response,
  });

  ReviewEntityOutputs copyWith({
    int? id,
    int? childId,
    String? reviewText,
    int? starsNum,
    String? updatedAt,
    String? createdAt,
    int? parentId,
    int? institutionId,
    String? status,
    String? isDeleted,
    List<String>? response,
  }) {
    return ReviewEntityOutputs(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      reviewText: reviewText ?? this.reviewText,
      starsNum: starsNum ?? this.starsNum,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      parentId: parentId ?? this.parentId,
      institutionId: institutionId ?? this.institutionId,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [id,childId,reviewText,starsNum,updatedAt,createdAt,parentId,institutionId,status,isDeleted,response];
}
