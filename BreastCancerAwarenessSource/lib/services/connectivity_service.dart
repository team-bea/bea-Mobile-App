import 'dart:async';

import 'package:connectivity/connectivity.dart';

enum ConnectionStatus { Wifi, Cellular, Offline }

//to check the internet connection
class ConnectivityService {
  Future<bool> isConnectedToNetwork() async {
    ConnectionStatus connectionStatus = await _checkConnection();
    if (connectionStatus == ConnectionStatus.Offline)
      return false;
    else
      return true;
  }

  Future<ConnectionStatus> _checkConnection() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();

    return _getStatusFromResult(result);


  }

  ConnectionStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectionStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectionStatus.Wifi;
      case ConnectivityResult.none:
        return ConnectionStatus.Offline;
      default:
        return ConnectionStatus.Offline;
    }
  }
}
