// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'di_container.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void configure() {
    final KiwiContainer container = KiwiContainer();
    container.registerSingleton((c) => ResolutionService(c<StorageService>()));
    container.registerSingleton((c) => NavigationService());
    container.registerSingleton((c) => StorageService());
  }
}
