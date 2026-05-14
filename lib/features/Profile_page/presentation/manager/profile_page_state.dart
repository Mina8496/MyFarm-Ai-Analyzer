part of 'profile_page_cubit.dart';

abstract class ProfilePageState {}

class FeatureInitial extends ProfilePageState {}

class FeatureLoading extends ProfilePageState {}

class FeatureLoaded extends ProfilePageState {
  final dynamic data; // غير النوع حسب الـ feature
  FeatureLoaded({required this.data});
}

class FeatureError extends ProfilePageState {
  final String message;
  FeatureError({required this.message});
}
