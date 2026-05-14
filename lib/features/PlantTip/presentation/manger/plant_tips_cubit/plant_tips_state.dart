import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

abstract class PlantTipsState {}

class PlantTipsInitial extends PlantTipsState {}

class PlantTipsLoading extends PlantTipsState {}

class PlantTipsLoaded extends PlantTipsState {
  final List<PlantTip> visibleTips;
  PlantTipsLoaded({required this.visibleTips});
}

class PlantTipsError extends PlantTipsState {
  final String message;
  PlantTipsError({required this.message});
}