import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:resolution/src/resolutions/blocs/resolution/resolution_bloc.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<ResolutionBloc>(
    lazy: false,
    create: (dynamic context) =>
        ResolutionBloc(RepositoryProvider.of<ResolutionService>(context)),
  ),
];

final KiwiContainer kiwiContainer = KiwiContainer();

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<ResolutionService>(
    create: (context) => kiwiContainer.resolve<ResolutionService>(),
  ),
];
