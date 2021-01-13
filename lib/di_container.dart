import 'package:kiwi/kiwi.dart';
import 'package:resolution/src/commons/services/storage_service.dart';
import 'package:resolution/src/resolutions/services/resolution_service.dart';

import 'src/commons/services/navigation_service.dart';

part 'di_container.g.dart';

abstract class Injector {
  @Register.singleton(ResolutionService)
  @Register.singleton(NavigationService)
  @Register.singleton(StorageService)

  void configure();
}

void setupDI() {
  var injector = _$Injector();
  injector.configure();
}
