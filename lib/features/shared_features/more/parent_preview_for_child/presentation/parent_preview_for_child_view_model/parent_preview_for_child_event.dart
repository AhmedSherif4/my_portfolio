part of '../../parent_preview_for_child.dart';

abstract class ParentPreviewForChildEvent extends Equatable {
  const ParentPreviewForChildEvent();

  @override
  List<Object> get props => [];
}

class GetAllParentsForChildEvent extends ParentPreviewForChildEvent {}
