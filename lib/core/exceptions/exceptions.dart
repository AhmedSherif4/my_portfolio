import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:my_portfolio/config/resources/app_strings.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException({required this.message});

  @override
  List<Object?> get props => [message];
}

class NoInternetConnectionException extends ServerException {
  NoInternetConnectionException()
      : super(message: AppStrings.noInternetConnection.tr());
}
