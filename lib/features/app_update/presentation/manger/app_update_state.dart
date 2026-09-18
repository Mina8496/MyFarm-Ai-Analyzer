import 'package:equatable/equatable.dart';

enum AppUpdateStatus { initial, checking, noUpdate, optionalUpdate, forceUpdate, error }

class AppUpdateState extends Equatable {
  final AppUpdateStatus status;
  final String message;

  const AppUpdateState({this.status = AppUpdateStatus.initial, this.message = ''});

  AppUpdateState copyWith({AppUpdateStatus? status, String? message}) {
    return AppUpdateState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}