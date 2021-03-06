import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';

part 'resolution_event.dart';
part 'resolution_state.dart';

class ResolutionBloc extends Bloc<ResolutionEvent, ResolutionState> {
  final ResolutionService resolutionService;

  ResolutionBloc(this.resolutionService) : super(InitialResolutionState());

  ResolutionState get initialState => InitialResolutionState();

  @override
  Stream<ResolutionState> mapEventToState(ResolutionEvent event) async* {
    if (event is SaveResolution) {
      yield SavingResolution();
      try {
        var response = await resolutionService.saveResolution(event.resolution);
        if (response is Resolution) {
          yield ResolutionSaved(response);
        }
      } catch (e) {
        yield ResolutionErrorState(AppStringConstants.saveFailed);
      }
    } else if (event is GetResolutions) {
      yield LoadingResolution();
      try {
        var response = await resolutionService.getAllResolution();
        if (response is List<Resolution>) {
          yield ResolutionsReceived(response);
        }
      } catch (e) {
        yield ResolutionErrorState(AppStringConstants.saveFailed);
      }
    }
  }
}
