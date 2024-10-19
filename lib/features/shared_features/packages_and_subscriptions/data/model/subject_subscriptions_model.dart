import '../../domain/entity/subject_subscriptions_entity.dart';

class SubjectSubscriptionsModel extends SubjectSubscriptionsEntity {
  const SubjectSubscriptionsModel({
    required super.optionalSubject,
    required super.terms,
  });

  factory SubjectSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return SubjectSubscriptionsModel(
      optionalSubject: List<SubjectForSubjectSubscriptionsEntity>.from(
        json['OptionalSubject'].map(
              (x) => SubjectForSubjectSubscriptionsModel.fromJson(x),
        ),
      ),
      terms: List<TermsForSubjectSubscriptionsEntity>.from(
        json['terms'].map(
          (x) => TermsForSubjectSubscriptionsModel.fromJson(x),
        ),
      ),
    );
  }
}



class TermsForSubjectSubscriptionsModel extends TermsForSubjectSubscriptionsEntity {
  const TermsForSubjectSubscriptionsModel({
    required super.message,
    required super.name,
    required super.subjects,
  });

  factory TermsForSubjectSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return TermsForSubjectSubscriptionsModel(
      message: json['message'],
      name: json['name'],
      subjects: List<SubjectForSubjectSubscriptionsEntity>.from(
        json['subjects'].map(
              (x) => SubjectForSubjectSubscriptionsModel.fromJson(x),
        ),
      ),
    );
  }
}


class SubjectForSubjectSubscriptionsModel extends SubjectForSubjectSubscriptionsEntity {
  const SubjectForSubjectSubscriptionsModel({
    required super.subjectName,
    required super.subjectID,
    required super.pathID,
    required super.subjectPrice,
    required super.subjectOldPrice,
    required super.isSubscribed,
    required super.cart,
    required super.isFree,
    required super.termID,
  });

  factory SubjectForSubjectSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return SubjectForSubjectSubscriptionsModel(
      subjectID: json['id'],
      pathID: json['path_id']??0,
      termID: json['term_id'],
      subjectName: json['name'],
      subjectPrice: json['price'],
      subjectOldPrice: json['old_price'],
      isSubscribed: json['is_subscribed'] ,
      cart: json['cart'] !=null? true:false,
      isFree: json['cart'] !=null? json['cart']['price']==0?true:false:false,
    );
  }
}
