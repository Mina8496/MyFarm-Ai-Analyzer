part of 'toolboxPage_cubit.dart';

abstract class FeatureState {}

class FeatureInitial extends FeatureState {}

class FeatureLoading extends FeatureState {}

class FeatureLoaded extends FeatureState {
  final dynamic data; // غير النوع حسب الـ feature
  FeatureLoaded({required this.data});
}

class FeatureError extends FeatureState {
  final String message;
  FeatureError({required this.message});
}