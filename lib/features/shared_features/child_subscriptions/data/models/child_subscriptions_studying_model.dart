import 'package:my_portfolio/my_app/app_reference.dart';

import '../../domain/entity/child_subscriptions_studying_entity.dart';

class ChildSubscriptionsStudyingModel extends ChildSubscriptionsStudyingEntity {
  const ChildSubscriptionsStudyingModel(
      {required super.id, required super.name, super.termHavePathOrNot});

  factory ChildSubscriptionsStudyingModel.fromJson(
      Map<String, dynamic> json, SubscriptionsType type) {
    switch (type) {
      case SubscriptionsType.stages:
        return ChildSubscriptionsStudyingModel(
          id: json['stage_id'],
          name: json['stage']['name'],
        );
      case SubscriptionsType.classRoom:
        return ChildSubscriptionsStudyingModel(
          id: json['classroom_id'],
          name: json['classroom']['name'],
        );
      case SubscriptionsType.terms:
        return ChildSubscriptionsStudyingModel(
          id: json['term_id'],
          name: json['term']['name'],
          termHavePathOrNot: json['term']['paths_count'] != null
              ? json['term']['paths_count'] > 0
                  ? true
                  : false
              : false,
        );
      case SubscriptionsType.system:
        return ChildSubscriptionsStudyingModel(
          // id: json['system']['id'] ?? 0,
          // name: json['system']['name'] ?? '',
          id: AppReference.userIsInstitution()?json['system']['id'] ?? 0:json['id'] ?? 0,
          name: AppReference.userIsInstitution()?json['system']['name'] ?? '':json['name'] ?? '',
        );
      case SubscriptionsType.paths:
        return ChildSubscriptionsStudyingModel(
          id: json['path']['id'],
          name: json['path']['name'],
        );
    }
  }

  @override
  List<Object> get props => [id, name];
}

enum SubscriptionsType {
  system,
  stages,
  classRoom,
  terms,
  paths,
}
