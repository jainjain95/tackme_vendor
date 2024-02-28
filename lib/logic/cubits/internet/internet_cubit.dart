import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCubit extends Cubit<bool> {
  late Connectivity _connectivity;
  late final StreamSubscription _subscription;

  InternetCubit() : super(true) {
    _connectivity = Connectivity();
    _emitInitialInternetState();
    _subscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      emit(result != ConnectivityResult.none);
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  _emitInitialInternetState() async {
    emit(await _isInternetAvailable());
  }

  Future<bool> _isInternetAvailable() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
