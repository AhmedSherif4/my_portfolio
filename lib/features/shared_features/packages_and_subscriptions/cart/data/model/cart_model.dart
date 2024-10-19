
import '../../domain/entity/cart_entity.dart';

class CartModel extends CartEntity {
  const CartModel({
    required super.totalPrice,
    required super.cart,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      totalPrice: json['total_price'],
      cart: List<ViewForCartEntity>.from(
        json['cart'].map(
          (x) => ViewCartModel.fromJson(x),
        ),
      ),
    );
  }
}



class ViewCartModel extends ViewForCartEntity {
  const ViewCartModel({
    required super.classroom,
    required super.term,
    required super.subjects,
  });

  factory ViewCartModel.fromJson(Map<String, dynamic> json) {
    return ViewCartModel(
      classroom: json['classroom'],
      term: json['term'],
      subjects: List<SubjectForCartEntity>.from(
        json['subjects'].map(
              (x) => SubjectModel.fromJson(x),
        ),
      ),
    );
  }
}


class SubjectModel extends SubjectForCartEntity {
  const SubjectModel({
    required super.subjectName,
    required super.subjectID,
    required super.subjectPrice,
    required super.childID,
    required super.createdAt,
    required super.termID,
    required super.pathID,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectID: json['subject']['id'],
      subjectName: json['subject']['name'],
      subjectPrice: json['price'],
      childID: json['child_id'],
      createdAt: json['created_at'],
      termID: json['term_id'],
      pathID: json['path_id']??0,
    );
  }
}
