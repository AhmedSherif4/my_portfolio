import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'child_subscriptions_studying_entity.g.dart';

@HiveType(typeId: 10)
class ChildSubscriptionsStudyingEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool termHavePathOrNot;

  const ChildSubscriptionsStudyingEntity({
    required this.id,
    required this.name,
    this.termHavePathOrNot = false,
  });

  @override
  List<Object> get props => [id, name,termHavePathOrNot];
}
