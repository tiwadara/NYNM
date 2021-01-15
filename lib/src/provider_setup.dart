import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:resolution/src/commons/services/notification_service.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';
import 'package:resolution/src/tasks/blocs/task/task_bloc.dart';
import 'package:resolution/src/tasks/services/task_service.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<TaskBloc>(
    lazy: false,
    create: (dynamic context) =>
        TaskBloc(RepositoryProvider.of<TaskService>(context)),
  ),
  BlocProvider<ResolutionBloc>(
    lazy: false,
    create: (dynamic context) =>
        ResolutionBloc(RepositoryProvider.of<ResolutionService>(context)),
  ),
];

final KiwiContainer kiwiContainer = KiwiContainer();

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<TaskService>(
    create: (context) => kiwiContainer.resolve<TaskService>(),
  ),
  RepositoryProvider<ResolutionService>(
    create: (context) => kiwiContainer.resolve<ResolutionService>(),
  ),
  RepositoryProvider<NotificationService>(
    create: (context) => kiwiContainer.resolve<NotificationService>(),
  ),
];
