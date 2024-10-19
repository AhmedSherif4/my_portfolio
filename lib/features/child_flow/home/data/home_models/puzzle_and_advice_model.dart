
import '../../domain/home_entities/puzzle_and_advice_entity.dart';

class PuzzleAndAdviceModel extends PuzzleAndAdviceEntity {
  const PuzzleAndAdviceModel({
    required super.advice,
    required super.content,
    required super.select1,
    required super.select2,
    required super.select3,
    required super.select4,
    required super.correctSelect,
  });

  factory PuzzleAndAdviceModel.fromMap(Map<String, dynamic> json) {
    return PuzzleAndAdviceModel(
      advice: json['advice'] as String,
      content: json['puzzle']['content'] as String,
      select1: json['puzzle']['select_1'] ?? '' ,
      select2: json['puzzle']['select_2'] ??"" ,
      select3: json['puzzle']['select_3'] ??"" ,
      select4: json['puzzle']['select_4'] ??"" ,
      correctSelect: json['puzzle']['correct_select'] ??"",
    );
  }
}
