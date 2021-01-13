import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resolution/src/app.dart';
import 'package:resolution/src/bloc_observer.dart';
import 'package:resolution/src/resolutions/models/resolution.dart';

import 'di_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHiveBox();
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

Future setupHiveBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ResolutionAdapter());
}
