import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kornia/app/router/route_names.dart';
import 'package:kornia/features/auth/presentation/state/auth_notifier.dart';
import '../../../../core/theme/app_colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await ref.read(authNotifierProvider.notifier).loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<void>>(authNotifierProvider, (_, next) {
      if (next is AsyncError && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo iniciar sesión. Inténtalo de nuevo.'),
            backgroundColor: AppColors.terracotta,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const _BrandIcon(),
                  const SizedBox(height: 24),
                  const _HeaderTexts(),
                  const SizedBox(height: 36),
                  _EmailField(controller: _emailController),
                  const SizedBox(height: 20),
                  _PasswordField(
                    controller: _passwordController,
                    obscure: _obscurePassword,
                    onToggle: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _RememberAndForgotRow(
                    rememberMe: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value;
                      });
                    },
                  ),
                  const SizedBox(height: 28),
                  _LoginButton(
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _handleLogin,
                  ),
                  const SizedBox(height: 24),
                  const _Divider(),
                  const SizedBox(height: 24),
                  const _SocialButtons(),
                  const SizedBox(height: 32),
                  const _RegisterRedirect(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets privados extraídos para mantener el build principal conciso.
// ---------------------------------------------------------------------------

class _BrandIcon extends StatelessWidget {
  const _BrandIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.bronzeGold.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.bronzeGold,
          size: 36,
        ),
      ),
    );
  }
}

class _HeaderTexts extends StatelessWidget {
  const _HeaderTexts();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Bienvenido a Kornia',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.sandLight,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Ingresa para descubrir piezas artesanales únicas',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.sandMuted,
            fontSize: 14.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Correo electrónico',
          style: TextStyle(
            color: AppColors.sandLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: AppColors.sandLight),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkSurface,
            hintText: 'ejemplo@correo.com',
            hintStyle: TextStyle(
              color: AppColors.sandDark.withValues(alpha: 0.8),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.sandMuted,
              size: 20,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.bronzeGold.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.bronzeGold,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.terracotta,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.terracotta,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Ingresa tu correo electrónico';
            }
            if (!RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            ).hasMatch(value.trim())) {
              return 'Ingresa un correo válido';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contraseña',
          style: TextStyle(
            color: AppColors.sandLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: AppColors.sandLight),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.darkSurface,
            hintText: '••••••••',
            hintStyle: TextStyle(
              color: AppColors.sandDark.withValues(alpha: 0.8),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.sandMuted,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.sandMuted,
                size: 20,
              ),
              onPressed: onToggle,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: AppColors.bronzeGold.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.bronzeGold,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.terracotta,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.terracotta,
                width: 1.5,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingresa tu contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _RememberAndForgotRow extends StatelessWidget {
  const _RememberAndForgotRow({
    required this.rememberMe,
    required this.onChanged,
  });

  final bool rememberMe;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: rememberMe,
                activeColor: AppColors.bronzeGold,
                checkColor: AppColors.darkBackground,
                side: BorderSide(
                  color: AppColors.sandDark.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (value) => onChanged(value ?? false),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Recordarme',
              style: TextStyle(
                color: AppColors.sandMuted,
                fontSize: 13.5,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // TODO: Implementar recuperación de contraseña
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            '¿Olvidaste tu contraseña?',
            style: TextStyle(
              color: AppColors.brightGold,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.bronzeGold,
        foregroundColor: AppColors.darkBackground,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 3,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.darkBackground,
              ),
            )
          : const Text(
              'Iniciar Sesión',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.sandDark.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'O continúa con',
            style: TextStyle(
              color: AppColors.sandDark.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.sandDark.withValues(alpha: 0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.g_mobiledata_rounded,
              size: 24,
              color: AppColors.sandLight,
            ),
            label: const Text(
              'Google',
              style: TextStyle(
                color: AppColors.sandLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.darkSurface,
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(
                color: AppColors.bronzeGold.withValues(alpha: 0.25),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.apple_rounded,
              size: 22,
              color: AppColors.sandLight,
            ),
            label: const Text(
              'Apple',
              style: TextStyle(
                color: AppColors.sandLight,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.darkSurface,
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(
                color: AppColors.bronzeGold.withValues(alpha: 0.25),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RegisterRedirect extends StatelessWidget {
  const _RegisterRedirect();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '¿No tienes una cuenta? ',
          style: TextStyle(
            color: AppColors.sandMuted,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            context.push(RouteNames.register);
          },
          child: const Text(
            'Regístrate',
            style: TextStyle(
              color: AppColors.brightGold,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
