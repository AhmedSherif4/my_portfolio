import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final List<ViewForCartEntity> cart;
  final int totalPrice;
  const CartEntity({
    required this.cart,
    required this.totalPrice,
  });

  CartEntity copyWith({
    List<ViewForCartEntity>? cart,
    int? totalPrice, required int childId,
  }) {
    return CartEntity(
      cart: cart ?? this.cart,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [cart, totalPrice];
}


class ViewForCartEntity extends Equatable {
  final String classroom;
  final String term;
  final List<SubjectForCartEntity> subjects;


  const ViewForCartEntity({
    required this.classroom,
    required this.term,
    required this.subjects,
  });

  @override
  List<Object?> get props =>
      [classroom, term, subjects];
}


class SubjectForCartEntity extends Equatable {
  final String subjectName;
  final int subjectID;
  final int termID;
  final int pathID;
  final int childID;
  final int subjectPrice;
  final String createdAt;


  const SubjectForCartEntity({
    required this.subjectName,
    required this.subjectID,
    required this.subjectPrice,
    required this.createdAt,
    required this.childID,
    required this.termID,
    required this.pathID,
  });

  @override
  List<Object?> get props =>
      [subjectName, subjectID, subjectPrice, createdAt, childID, termID,pathID];
}
