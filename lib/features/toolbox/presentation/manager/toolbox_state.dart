part of 'toolboxPage_cubit.dart';

abstract class ToolboxPageState {}

class ToolboxPageInitial extends ToolboxPageState {}

class ToolboxPageLoading extends ToolboxPageState {}

class ToolboxPageLoaded extends ToolboxPageState {
  final dynamic data; // غير النوع حسب الـ feature
  ToolboxPageLoaded({required this.data});
}

class ToolboxPageError extends ToolboxPageState {
  final String message;
  ToolboxPageError({required this.message});
}
