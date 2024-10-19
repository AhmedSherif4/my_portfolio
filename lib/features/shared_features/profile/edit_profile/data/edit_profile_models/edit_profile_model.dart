part of '../../edit_profile.dart';

class DataToGoToEditProfileScreen extends Equatable {
  final String title;
  final String oldData;

  const DataToGoToEditProfileScreen({
    required this.title,
    required this.oldData,
  });

  @override
  List<Object> get props => [title, oldData];
}
