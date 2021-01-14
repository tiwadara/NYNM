part of 'resolution_bloc.dart';

@immutable
abstract class ResolutionState extends Equatable {
  const ResolutionState();
}

class InitialResolutionState extends ResolutionState {
  @override
  List<Object> get props => [];
}

class SavingResolution extends ResolutionState {
  @override
  List<Object> get props => [];
}

class LoadingResolution extends ResolutionState {
  @override
  List<Object> get props => [];
}

@immutable
class ResolutionSaved extends ResolutionState {
  final Resolution resolution;
  ResolutionSaved(this.resolution);
  @override
  List<Object> get props => [resolution];
}

@immutable
class ResolutionsReceived extends ResolutionState {
  final List<Resolution> resolutions;
  ResolutionsReceived(this.resolutions);
  @override
  List<Object> get props => [resolutions];
}

@immutable
class ErrorWithMessageState extends ResolutionState {
  final String error;
  ErrorWithMessageState(this.error);
  @override
  List<Object> get props => [error];
}
