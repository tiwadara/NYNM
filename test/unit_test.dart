import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resolution/src/commons/constants/app_strings.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';

class MockStorageService extends Mock implements StorageService {}

class MockResolutionService extends Mock implements ResolutionService {}

main() {
  // **************  UNIT TESTS ***********************

  // unit test Services
  group('ResolutionService Test | ', () {
    ResolutionService resolutionService;
    StorageService storageService;

    setUp(() async {
      Resolution testResolution = Resolution();
      storageService = MockStorageService();
      resolutionService = ResolutionService(storageService);

      storageService.saveResolution(testResolution);
      verify(storageService.saveResolution(testResolution));

      when(storageService.saveResolution(testResolution)).thenAnswer((_) => Future.value(testResolution));
      expect(await storageService.saveResolution(testResolution), testResolution);
    });

    test('Constructing Service should find correct dependencies', () {
      expect(resolutionService != null, true);
      expect(storageService != null, true);
    });

    test('add resolution', () async {
      Resolution newResolution = await resolutionService.saveResolution(Resolution(name: "One"));
      expect(newResolution.name, "One");
      Resolution savedResolution = await resolutionService.getResolution(Resolution(name: "One"));
      expect(savedResolution.name, "One");
    });
  });

  // unit test blocs

  group('ResolutionBloc Test -', () {
    ResolutionService resolutionService;
    ResolutionBloc resolutionBloc;

    setUp(() {
      resolutionService = MockResolutionService();
      resolutionBloc = ResolutionBloc(resolutionService);
    });

    tearDown(() {
      resolutionBloc?.close();
    });

    test('initial state is correct', () {
      expect(resolutionBloc.initialState, InitialResolutionState());
    });

    group('createResolution -', () {
      Resolution testResolution = Resolution();

      blocTest('emits [SavingResolution, ResolutionSaved] when SaveResolution is added and saveResolution succeeds',
        build: () {
        when(resolutionService.saveResolution(testResolution)).thenAnswer((_) => Future.value(testResolution),);
          return resolutionBloc;
        },
        act: (bloc) => bloc.add(SaveResolution(testResolution)),
        expect: [
          SavingResolution(),
          ResolutionSaved(testResolution)
        ],
      );

      blocTest('emits [SavingResolution, ErrorWithMessageState] when SaveResolution is added and saveResolution fails',
        build: () {
          when(resolutionService.saveResolution(testResolution)).thenThrow((_) => Future.value("testResolution"));
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
