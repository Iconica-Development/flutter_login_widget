import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

/// A wrapper that wraps a widget with a [Semantics] widget.
/// This is used for testing purposes to add a unique identifier to a widget.
/// The [identifier] should be unique
/// [container] is set to true to make sure the widget is always its own
/// accessibility element.
/// [excludeSemantics] is set to false to make sure that the widget can still
/// receive input.
class CustomSemantics extends StatelessWidget {
  /// Creates a [CustomSemantics] widget.
  /// The [identifier] should be unique for the specific screen.
  const CustomSemantics({
    required this.identifier,
    required this.child,
    super.key,
  });

  /// The widget that should be wrapped with a [Semantics] widget.
  final Widget child;

  /// Identifier for the widget that should be unique for the specific screen.
  final String identifier;

  @override
  Widget build(BuildContext context) => Semantics(
        excludeSemantics: false,
        container: true,
        label: kIsWeb || Platform.isIOS ? null : identifier,
        identifier: identifier,
        child: child,
      );
}
