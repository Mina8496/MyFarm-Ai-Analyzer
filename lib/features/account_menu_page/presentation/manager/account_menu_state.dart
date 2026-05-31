part of 'account_menu_cubit.dart';

abstract class AccountMenuPageState {}

class FeatureInitial extends AccountMenuPageState {}

class FeatureLoading extends AccountMenuPageState {}

class FeatureLoaded extends AccountMenuPageState {
  final dynamic data; // غير النوع حسب الـ feature
  FeatureLoaded({required this.data});
}

class FeatureError extends AccountMenuPageState {
  final String message;
  FeatureError({required this.message});
}
