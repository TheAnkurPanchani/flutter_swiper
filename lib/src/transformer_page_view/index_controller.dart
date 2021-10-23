import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class IndexControllerEventBase {
  final bool animation;
  final completer = Completer<void>();
  Future<void> get future => completer.future;
  void complete() {
    if (!completer.isCompleted) {
      completer.complete();
    }
  }

  IndexControllerEventBase({
    required this.animation,
  });
}

mixin StepBasedIndexControllerEvent on IndexControllerEventBase {
  int get step;
  double get targetPosition;
  int calcNextIndex({
    required int currentIndex,
    required int itemCount,
    required bool loop,
    required bool reverse,
  }) {
    var cIndex = currentIndex;
    if (reverse) {
      cIndex -= step;
    } else {
      cIndex += step;
    }

    if (!loop) {
      if (cIndex >= itemCount) {
        cIndex = 0;
      } else if (cIndex < 0) {
        cIndex = itemCount - 1;
      }
    }
    return cIndex;
  }
}

class NextIndexControllerEvent extends IndexControllerEventBase
    with StepBasedIndexControllerEvent {
  NextIndexControllerEvent({
    required bool animation,
  }) : super(
          animation: animation,
        );

  @override
  int get step => 1;

  @override
  double get targetPosition => 1;
}

class PrevIndexControllerEvent extends IndexControllerEventBase
    with StepBasedIndexControllerEvent {
  PrevIndexControllerEvent({
    required bool animation,
  }) : super(
          animation: animation,
        );
  @override
  int get step => -1;

  @override
  double get targetPosition => 0;
}

class MoveIndexControllerEvent extends IndexControllerEventBase {
  MoveIndexControllerEvent({
    required bool animation,
  }) : super(
          animation: animation,
        );
}

class IndexController extends ChangeNotifier {
  IndexControllerEventBase? event;
  int index = 0;
  Future move(int index, {bool animation = true}) {
    final e = event = MoveIndexControllerEvent(
      animation: animation,
    );
    this.index = index;
    notifyListeners();
    return e.future;
  }

  Future next({bool animation = true}) {
    final e = event = NextIndexControllerEvent(animation: animation);
    notifyListeners();
    return e.future;
  }

  Future previous({bool animation = true}) {
    final e = event = PrevIndexControllerEvent(animation: animation);
    notifyListeners();
    return e.future;
  }
}
