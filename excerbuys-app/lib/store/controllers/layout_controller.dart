import 'package:rxdart/rxdart.dart';

class LayoutController {
  final BehaviorSubject<double> _statusBarHeight = BehaviorSubject.seeded(0.0);
  Stream<double> get statusBarHeightStream => _statusBarHeight.stream;
  double get statusBarHeight => _statusBarHeight.value;
  setStatusBarHeight(double val) {
    _statusBarHeight.add(val);
  }

  final BehaviorSubject<double> _relativeContentHeight =
      BehaviorSubject.seeded(0.0);
  Stream<double> get relativeContentHeightStream =>
      _relativeContentHeight.stream;
  double get relativeContentHeight => _relativeContentHeight.value;
  setRelativeConetntHeight(double val) {
    _relativeContentHeight.add(val);
  }
}

LayoutController layoutController = LayoutController();
