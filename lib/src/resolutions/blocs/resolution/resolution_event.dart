part of 'resolution_bloc.dart';

@immutable
abstract class ResolutionEvent extends Equatable {
  const ResolutionEvent();
}

@immutable
class SaveResolution extends ResolutionEvent {
  final Resolution resolution;

  SaveResolution(this.resolution);
  @override
  List<Object> get props => [resolution];
}

@immutable
class GetResolutions extends ResolutionEvent {
  @override
  List<Object> get props => [];
}
