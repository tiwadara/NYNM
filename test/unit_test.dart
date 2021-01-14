import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/commons/constants/storage_constants.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/tasks/blocs/todo/to_do_bloc.dart';
import 'package:resolution/src/tasks/models/task.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

class MockStorageService extends Mock implements StorageService {}

class MockResolutionService extends Mock implements TaskService {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveBox extends Mock implements Box {}

main() {
  // **************  UNIT TESTS ***********************

  // unit test Services
  group('ResolutionService Test | ', () {
    TaskService resolutionService;
    StorageService storageService;

    setUp(() async {
      Task testResolution = Task();
      storageService = MockStorageService();
      resolutionService = TaskService(storageService);

      storageService.saveResolution(testResolution);
      verify(storageService.saveResolution(testResolution));

      when(storageService.saveResolution(testResolution))
          .thenAnswer((_) => Future.value(testResolution));
      expect(
          await storageService.saveResolution(testResolution), testResolution);
    });

    test('Constructing Service should find correct dependencies', () {
      expect(resolutionService != null, true);
      expect(storageService != null, true);
    });

    test('save resolution', () async {
      Task testResolution = Task(name: "Two");
      when(storageService.saveResolution(any))
          .thenAnswer((_) => Future.value(testResolution));
      Task newResolution =
          await resolutionService.saveResolution(Task(name: "One"));
      expect(newResolution, testResolution);
    });

    test('get resolution', () async {
      Task testResolution = Task(name: "Two");
      when(storageService.getResolution(any))
          .thenAnswer((_) => Future.value(testResolution));
      Task savedResolution =
          await resolutionService.getResolution(Task(name: "One"));
      expect(savedResolution, testResolution);
    });

    test('get resolutions', () async {
      when(storageService.getAllResolutions())
          .thenAnswer((_) => Future.value(List<Task>()));
      List<Task> resolutions = await resolutionService.getAllResolution();
      expect(resolutions, []);
    });
  });

  // unit test blocs

  group('ResolutionBloc Test -', () {
    TaskService resolutionService;
    ToDoBloc resolutionBloc;

    setUp(() {
      resolutionService = MockResolutionService();
      resolutionBloc = ToDoBloc(resolutionService);
    });

    tearDown(() {
      resolutionBloc?.close();
    });

    test('initial state is correct', () {
      expect(resolutionBloc.initialState, InitialResolutionState());
    });

    group('createResolution -', () {
      Task testResolution = Task();

      blocTest(
        'emits [SavingResolution, ResolutionSaved] when SaveResolution is added and saveResolution succeeds',
        build: () {
          when(resolutionService.saveResolution(testResolution)).thenAnswer(
            (_) => Future.value(testResolution),
          );
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [SavingResolution(), ResolutionSaved(testResolution)],
      );

      blocTest(
        'emits [SavingResolution, ErrorWithMessageState] when SaveResolution is added and saveResolution fails',
        build: () {
          when(resolutionService.saveResolution(testResolution))
              .thenThrow((_) => Future.value("testResolution"));
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [
          SavingResolution(),
          ErrorWithMessageState(AppStringConstants.saveFailed)
        ],
      );
    });
  });
}
