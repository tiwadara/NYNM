import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resolution/src/app.dart';
import 'package:resolution/src/bloc_observer.dart';
import 'package:resolution/src/commons/services/storage_service.dart';

import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StorageService.init();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? null : await getApplicationDocumentsDirectory(),
  );
  setupDI();
  Bloc.observer = AppBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}
