import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _appVersion = '1.0.0';

  // URL de destino a configurar por el desarrollador
  static const String _developerUrl = 'https://peregrinus.dev';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _appVersion = packageInfo.version;
        });
      }
    } catch (_) {
      // Fallback a versión inicial si ocurre algún error
    }
  }

  Future<void> _launchDeveloperUrl() async {
    final Uri uri = Uri.parse(_developerUrl);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error al abrir URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Información',
          style: TextStyle(
            color: AppColors.sandLight,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontFamily: 'serif',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Logo / Brand Icon Card
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.bronzeGold.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.antiqueBronze.withValues(alpha: 0.2),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover),
              ),
              const SizedBox(height: 18),

              const Text(
                'Kornia Artesanías',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                  letterSpacing: 1.2,
                  color: AppColors.sandLight,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Alta Orfebrería y Cuerno Artesanal',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bronzeGold,
                ),
              ),
              const SizedBox(height: 28),

              // About Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.bronzeGold.withValues(alpha: 0.2),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nuestra Historia',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                        color: AppColors.sandLight,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'En Kornia transformamos astas bovinas y materiales nobles en piezas de arte irrepetibles. Cada creación es labrada a mano por maestros artesanos preservando técnicas milenarias.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: AppColors.sandMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Contact & Details
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.bronzeGold.withValues(alpha: 0.2),
                  ),
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.bronzeGold,
                          size: 22,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Taller Central',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.sandLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 28, color: AppColors.darkBackground),
                    Row(
                      children: [
                        Icon(
                          Icons.verified_outlined,
                          color: AppColors.bronzeGold,
                          size: 22,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Autenticidad Garantizada',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.sandLight,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Certificado de origen y autoría en cada pieza',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.sandMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Developer info & Dynamic Pubspec Version
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    GestureDetector(
                      onTap: _launchDeveloperUrl,
                      child: const Text(
                        'Desarrollado por Peregrinus',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.bronzeGold,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.bronzeGold,
                        ),
                      ),
                    ),
                    Text(
                      'Versión $_appVersion',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.sandDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

