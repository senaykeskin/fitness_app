import 'package:flutter/material.dart';
import '../../global/global_functions.dart';
import 'index.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  final BehaviorSubject<bool> _permissionGrantedSubject =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String?> _scanResultSubject =
      BehaviorSubject<String?>.seeded(null);
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
    _listenToScanResult();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _permissionGrantedSubject.add(true);
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      if (mounted) {
        showSnackBar(context, "Kamera izni gerekli.");
      }
    }
  }

  @override
  void dispose() {
    _permissionGrantedSubject.close();
    _scanResultSubject.close();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      if (_scanResultSubject.value == null) {
        controller.pauseCamera();
        _scanResultSubject.add(scanData.code);
      }
    });
  }

  void _listenToScanResult() {
    _scanResultSubject.stream.listen((code) {
      if (code != null && !_dialogShown) {
        _dialogShown = true;
        _showSuccessDialog(code);
      }
    });
  }

  void _showSuccessDialog(String code) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 100)),
          builder: (context, snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/successful.json',
                  width: 250,
                  height: 250,
                  repeat: false,
                ),
                const SizedBox(height: 10),
                Text(
                  "QR Kodu okundu!",
                  style: kAxiformaRegular17.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          },
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          RouteAnimation.createRoute(CTabbar(), -1.0, 0.0),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _permissionGrantedSubject.stream,
      builder: (context, snapshot) {
        final hasPermission = snapshot.data ?? false;

        if (!hasPermission) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Center(
            child: SizedBox(
              width: W(context) * 0.9,
              height: W(context) * 0.9,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: GlobalConfig.primaryColor,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 15,
                  cutOutSize: W(context) * 0.75,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
