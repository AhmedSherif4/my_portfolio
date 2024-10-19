import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_portfolio/core/usecase/base_usecase.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/entity/notification_entity.dart';
import 'package:my_portfolio/features/shared_features/notification/domain/use_case/notification_use_case.dart';
import '../../../../../core/enum/enum_generation.dart';
import '../../../rank/rank.dart';
import '../../domain/repository/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

@Injectable()
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUseCase notificationUseCase;
  final ReadAllNotificationUseCase readAllNotificationUseCase;
  final UpdateNotificationUseCase updateNotificationUseCase;

  int nextPage = 1;
  NotificationBloc(this.notificationUseCase, this.readAllNotificationUseCase,
      this.updateNotificationUseCase)
      : super(const NotificationState()) {
    on<GetAllNotificationEvent>((GetAllNotificationEvent event, emit) async {
      emit(state.copyWith(
          notificationStates: RequestStates.loading,
          updateNotificationState: RequestStates.initial));

      final result = await notificationUseCase(
        event.pageNumber,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            notificationStates: RequestStates.error,
            notificationMessage: failure.message,
          ));
        },
        (notification) {
          if(notification.paginationEntity.lastPage != 1){
            nextPage = nextPage + 1;
          }
          // notification.paginationEntity.lastPage.log();
          emit(
            state.copyWith(
              notificationStates: RequestStates.loaded,
              allNotifications: [
                ...state.allNotifications,
                ...notification.notifications
              ],
              paginationModel: notification.paginationEntity,
              unNotificationCount: notification.unReadNotificationCount,
              isLastPage: nextPage == notification.paginationEntity.lastPage,
            ),
          );
        },
      );
    });


    on<ReadAllNotificationEvent>((event, emit) async {
      await readAllNotificationUseCase(const NoParameter());
    });

    on<UpdateNotificationEvent>(
        (UpdateNotificationEvent event, Emitter<NotificationState> emit) async {
      emit(
        state.copyWith(
            updateNotificationState: RequestStates.loading,
            notificationStates: RequestStates.initial),
      );
      final result =
          await updateNotificationUseCase(event.notificationManagerParameters);
      result.fold(
        (l) => emit(state.copyWith(
            updateNotificationState: RequestStates.error,
            updateNotificationMessage: l.toString())),
        (r) => emit(state.copyWith(
            updateNotificationState: RequestStates.loaded,
            updateNotificationMessage: r.toString())),
      );
    });
  }




}
