import 'package:flutter/material.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/check_connnection.dart';
import 'package:flutter_rabin_karp_algorithm_app/utils/finite_state.dart';

class SplashController with ChangeNotifier {
  //this variable is used to store the Finite State enum
  FiniteState _finiteState = FiniteState.init;
  //this variable is used to store the connection status
  bool? _isConnectingToInternet;

  //this is the getter of _finiteState
  FiniteState get finiteState => _finiteState;
  //this is the getter of _isConnectingToInternet;
  bool? get isConnectingToInternet => _isConnectingToInternet;

  //this is the setter of isConnectingToInternet
  set isConnectingToInternet(bool? value) => _isConnectingToInternet = value;

  ///this function aims to change the Finite State and triggering the consumer widget
  ///
  ///created on January 18th, 2025
  void changeFiniteState({required FiniteState value}) {
    _finiteState = value;
    notifyListeners();
  }

  ///this function aims to check the internet connection
  ///
  ///created on January 18th, 2025
  Future<void> checkInternetConnection() async {
    try {
      changeFiniteState(value: FiniteState.loading);
      _isConnectingToInternet = await CheckConnection.execute();
      changeFiniteState(value: FiniteState.succeed);
    } catch (e) {
      changeFiniteState(value: FiniteState.failed);
      throw Exception(e);
    }
  }
}
