/// This module is used for writing tests for applications written in Angular.
///
/// This module is not included in the `angular2` module; you must import the
/// test module explicitly.
library angular2.testing;

import 'package:angular2/src/core/change_detection.dart';
import 'package:angular2/src/core/linker/view_ref.dart';
import 'package:angular2/src/debug/debug_app_view.dart';
import 'package:meta/meta.dart';

export "src/compiler/xhr_mock.dart" show MockXHR;
export "src/debug/debug_node.dart" show DebugElement, By;
export "src/mock/directive_resolver_mock.dart" show MockDirectiveResolver;
export "src/mock/mock_application_ref.dart" show MockApplicationRef;
export "src/mock/ng_zone_mock.dart" show MockNgZone;
export "src/mock/view_resolver_mock.dart" show MockViewResolver;
export "src/testing/fake_async.dart";
export "src/testing/test_component_builder.dart"
    show ComponentFixture, TestComponentBuilder;
export "src/testing/test_injector.dart";

/// Returns whether [ChangeDetectorRef] was generated in debug mode.
///
/// When running automated performance benchmarks you may want to ensure that
/// the application is running as release:
/// ```
/// import 'package:angular2/testing.dart';
///
/// @Component(...)
/// class RootComponent {
///   RootComponent(ChangeDetectorRef changeDetectorRef) {
///     if (isDebugMode(changeDetectorRef)) {
///       throw 'Performance benchmarks should be run in release mode.';
///     }
///   }
/// }
/// ```
@visibleForTesting
bool isDebugMode(ChangeDetectorRef changeDetectorRef) {
  // DO NOT COPY AND PASTE. THIS IS NOT PART OF THE PUBLIC API.
  return (changeDetectorRef as ViewRefImpl).appView is DebugAppView;
}

@visibleForTesting
void assertReleaseMode(ChangeDetectorRef changeDetectorRef) {
  if (isDebugMode(changeDetectorRef)) {
    throw 'Expected RELEASE mode, got DEBUG mode. Check your codegen options';
  }
}

@visibleForTesting
void assertDebugMode(ChangeDetectorRef changeDetectorRef) {
  if (!isDebugMode(changeDetectorRef)) {
    throw 'Expected DEBUG mode, got RELEASE mode. Check your codegen options';
  }
}
