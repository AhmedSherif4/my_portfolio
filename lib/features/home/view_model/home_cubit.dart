import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part './home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final scrollController = ScrollController();

  void scrollToSection(GlobalKey section) {
    Scrollable.ensureVisible(section.currentContext!,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  void scrollListener() {
    emit(state.copyWith(showTopButton: scrollController.offset >= 200));
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
}
