import 'package:flutter/material.dart';
import 'package:techmart/features/authentication/presentation/screens/section_tile_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our application.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              buildSectionTitle("1. Information We Collect"),
              buildBulletPoint(
                "Personal Data (Name, Email, Phone Number, etc.)",
              ),
              buildBulletPoint("Payment Information (only for transactions)"),
              buildBulletPoint("Device and Log Data"),

              const SizedBox(height: 16),
              buildSectionTitle("2. How We Use Your Information"),
              buildBulletPoint("To process orders and deliver products"),
              buildBulletPoint("To provide customer support"),
              buildBulletPoint("To personalize user experience"),
              buildBulletPoint("To improve app features and functionality"),

              const SizedBox(height: 16),
              buildSectionTitle("3. Sharing Your Information"),
              buildBulletPoint("We do not sell or rent your data."),
              buildBulletPoint(
                "We may share with service providers for order processing or analytics.",
              ),

              const SizedBox(height: 16),
              buildSectionTitle("4. Data Security"),
              const Text(
                "We use industry-standard security measures to protect your data. However, no method of transmission is 100% secure.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),
              buildSectionTitle("5. Your Rights"),
              buildBulletPoint(
                "You have the right to access, update, or delete your personal data.",
              ),
              buildBulletPoint(
                "You can request data export or removal anytime.",
              ),

              const SizedBox(height: 16),
              buildSectionTitle("6. Changes to this Policy"),
              const Text(
                "We may update this policy occasionally. Changes will be posted in this app.",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),
              buildSectionTitle("7. Contact Us"),
              const Text(
                "If you have any questions about this policy, contact us at: support@yourapp.com",
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
