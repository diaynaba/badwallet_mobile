import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../../dashboard/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              const Center(
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 90,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Bienvenue 👋",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Connectez-vous avec votre numéro de téléphone",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              CustomTextField(
                controller: phoneController,
                hint: "77000001",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                text: "Continuer",
                isLoading: authProvider.isLoading,
                onPressed: () async {

                  if (phoneController.text.trim().isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Veuillez saisir votre numéro"),
                      ),
                    );

                    return;

                  }

                  await authProvider.login(
                    phoneController.text.trim(),
                  );

                  if (!mounted) return;

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}