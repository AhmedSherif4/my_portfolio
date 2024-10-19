import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'terms_and_conditions_entity.g.dart';

@HiveType(typeId: 11)
class TermsAndConditionsEntity extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;

  const TermsAndConditionsEntity({required this.title, required this.content});

  @override
  List<Object> get props => [title, content];
}
