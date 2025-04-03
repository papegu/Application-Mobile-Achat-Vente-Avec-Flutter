import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  /// 🔹 Ouvre l'application Wave pour le paiement
  Future<void> openWavePayment(String phoneNumber, double amount) async {
    String waveUrl = "wave://pay?phone=$phoneNumber&amount=$amount";

    if (await canLaunchUrl(Uri.parse(waveUrl))) {
      await launchUrl(Uri.parse(waveUrl));
    } else {
      throw Exception("Impossible d'ouvrir Wave.");
    }
  }
}
