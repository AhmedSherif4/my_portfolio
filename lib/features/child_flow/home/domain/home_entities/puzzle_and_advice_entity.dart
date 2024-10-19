import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';


part 'puzzle_and_advice_entity.g.dart';

@HiveType(typeId: 9)
class PuzzleAndAdviceEntity extends Equatable {
  @HiveField(0)
  final String advice;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final String? select1;
  @HiveField(3)
  final String? select2;
  @HiveField(4)
  final String? select3;
  @HiveField(5)
  final String? select4;
  @HiveField(6)
  final String? correctSelect;

  const PuzzleAndAdviceEntity({required this.advice, required this.content, required this.select1, required this.select2, required this.select3, required this.select4, required this.correctSelect});

  @override
  List<Object?> get props => [advice, content, select1, select2, select3, select4, correctSelect];
}
