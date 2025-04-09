import 'package:flutter/material.dart';
import 'index.dart';

class ShowQrCode extends StatefulWidget {
  const ShowQrCode({super.key});

  @override
  State<ShowQrCode> createState() => _ShowQrCodeState();
}

class _ShowQrCodeState extends State<ShowQrCode> {
  final BehaviorSubject<int> _timerSubject = BehaviorSubject<int>.seeded(30);
  final BehaviorSubject<bool> _isExpiredSubject = BehaviorSubject<bool>.seeded(false);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _generateQrCode();
    _startTimer();
  }

  @override
  void dispose() {
    _timerSubject.close();
    _isExpiredSubject.close();
    _timer?.cancel();
    super.dispose();
  }

  void _generateQrCode() {
    final data = {'userId': '12345'};
    final encoded = jsonEncode(data);
    qrDataSubject.add(encoded); // Assuming qrDataSubject is defined in your index.dart
  }

  void _startTimer() {
    _timer?.cancel();
    _isExpiredSubject.add(false);
    _timerSubject.add(30); // Reset the timer to 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = _timerSubject.value;
      if (current > 0) {
        _timerSubject.add(current - 1); // Decrease the timer value
      } else {
        _timer?.cancel();
        _isExpiredSubject.add(true); // Timer expired
        _showExpirationDialog();
      }
    });
  }

  void _showExpirationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "QR Süresi Doldu",
          textAlign: TextAlign.center,
          style: kAxiformaRegular17.copyWith(
              fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text(
              "Kapat",
              style: kAxiformaRegular17.copyWith(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _generateQrCode(); // Generate a new QR code
              _startTimer(); // Restart the timer
              _isExpiredSubject.add(false); // Reset expired state
            },
            child: Text(
              "Yeniden Oluştur",
              style: kAxiformaRegular17.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isExpiredSubject.stream,
      builder: (context, snapshot) {
        final isExpired = snapshot.data ?? false;

        if (isExpired) {
          return _buildExpiredState();
        }

        return StreamBuilder<String>(
          stream: qrDataSubject.stream, // Assuming qrDataSubject is the stream for QR data
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return _buildQrCodeDisplay(snapshot.data!);
          },
        );
      },
    );
  }

  Widget _buildExpiredState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.qr_code_2_outlined, size: 100, color: Colors.grey),
          const SizedBox(height: 10),
          Text(
            "QR kod süresi doldu.",
            style: kAxiformaRegular17.copyWith(
                color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalConfig.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: border15),
              elevation: 1,
            ),
            onPressed: () {
              _generateQrCode();
              _startTimer();
              _isExpiredSubject.add(false);
            },
            child: Text(
              "Yeniden Oluştur",
              style: kAxiformaRegular17.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrCodeDisplay(String qrData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: 200.0,
        ),
        const SizedBox(height: 20),
        StreamBuilder<int>(
          stream: _timerSubject.stream,
          builder: (context, timerSnapshot) {
            final seconds = timerSnapshot.data ?? 0;
            return Text(
              "Süre: $seconds saniye",
              style: kAxiformaRegular17.copyWith(
                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
            );
          },
        ),
      ],
    );
  }
}
