
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/main_state.dart';
import 'package:local_auth/local_auth.dart';

class MainBloc extends Cubit<MainState> {

  MainBloc(MainState state) : super(state) {
    _checkBiometrics();
    _getAvailableBiometrics();
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;



  Future<void> _checkBiometrics() async {
    try {
      _canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      _canCheckBiometrics = false;
    } catch(e) {
      _canCheckBiometrics = false;
    }
  }

  Future<void> _getAvailableBiometrics() async {
    try {
      _availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
      _availableBiometrics = [];
    } catch(e) {
      _availableBiometrics = [];
    }
  }

  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
      authenticated = false;
    } catch(e) {
      authenticated = false;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
}