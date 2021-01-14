import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final TaskService resolutionService;

  ToDoBloc(this.resolutionService) : super(InitialResolutionState());

  ToDoState get initialState => InitialResolutionState();

  @override
  Stream<ToDoState> mapEventToState(ToDoEvent event) async* {
    if (event is SaveResolution) {
      yield SavingResolution();
      try {
        var response = await resolutionService.saveResolution(event.resolution);
        if (response is Task) {
          yield ResolutionSaved(response);
        } else {
          yield ErrorWithMessageState(AppStringConstants.saveFailed);
        }
      } catch (e) {
        yield ErrorWithMessageState(AppStringConstants.saveFailed);
      }
    } else if (event is GetResolutions) {
      yield LoadingResolution();
      try {
        var response = await resolutionService.getAllResolution();
        if (response.isNotEmpty) {
          yield ResolutionsReceived(response);
        } else {
          yield ErrorWithMessageState(AppStringConstants.saveFailed);
        }
      } catch (e) {
        yield ErrorWithMessageState(AppStringConstants.saveFailed);
      }
    } else if (event is UpdateResolutionStatus) {
      yield UpdatingResolution();
      try {
        var response = await resolutionService.updateResolution(
            event.resolution, event.index);
        if (response is Task) {
          yield ResolutionUpdated(response);
        } else {
          yield ErrorWithMessageState(AppStringConstants.saveFailed);
        }
      } catch (e) {
        yield ErrorWithMessageState(AppStringConstants.saveFailed);
      }
    }
  }
}
