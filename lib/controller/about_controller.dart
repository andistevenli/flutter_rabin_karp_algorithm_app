import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';

class AboutController with ChangeNotifier {
  //this variable is used to store the Finite State enum
  FiniteState _finiteState = FiniteState.init;

  //this is the getter of _finiteState
  FiniteState get finiteState => _finiteState;

  ///this function aims to change the Finite State and triggering the consumer widget
  ///
  ///created on January 18th, 2025
  void changeFiniteState({required FiniteState value}) {
    _finiteState = value;
    notifyListeners();
  }
}
