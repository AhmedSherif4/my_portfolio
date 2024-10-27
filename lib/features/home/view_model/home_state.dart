part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool showTopButton;

  const HomeState({
    this.showTopButton = false,
  });

  copyWith({
    bool? showTopButton,
  }) {
    return HomeState(
      showTopButton: showTopButton ?? this.showTopButton,
    );
  }

  @override
  List<Object> get props => [showTopButton];
}
