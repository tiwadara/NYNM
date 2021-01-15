part of 'task_bloc.dart';

@immutable
abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

@immutable
class SaveTask extends TaskEvent {
  final Task task;
  final int year;

  SaveTask(this.task, this.year);
  @override
  List<Object> get props => [task, year];
}

@immutable
class UpdateTaskStatus extends TaskEvent {
  final Task resolution;
  final int year;
  final int index;

  UpdateTaskStatus(this.resolution, this.year, this.index);
  @override
  List<Object> get props => [resolution, year, index];
}

@immutable
class GetTasks extends TaskEvent {
  final int year;
  GetTasks(this.year);
  @override
  List<Object> get props => [year];
}
