import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../services/revenue_cat_service.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isLoading = false;
  String? _error;

  Future<void> _purchase(bool isSubscription) async {
    setState(() { _isLoading = true; _error = null; });
    try {
      if (isSubscription) {
        await RevenueCatService.purchaseSubscription();
      } else {
        await RevenueCatService.purchaseOneTime();
      }
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() { _error = e.toString(); });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text('Unlock everything.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32, fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                )),
              const SizedBox(height: 8),
              Text('One payment. No ads. No limits.',
                style: GoogleFonts.inter(
                  fontSize: 16, color: AppColors.textSecondary,
                )),

              const SizedBox(height: 40),

              _Feature('All 3 branches (Romantic, Spicy, Deep)'),
              _Feature('All 5 intensity levels'),
              _Feature('Unlimited actions & questions'),
              _Feature('Session replay & stats'),

              const Spacer(),

              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(_error!,
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.redAccent)),
                ),

              _PayButton(
                label: '€19.99 — Lifetime Access',
                isLoading: _isLoading,
                onTap: () => _purchase(false),
              ),

              const SizedBox(height: 12),

              _PayButton(
                label: '€4.99/mo — Cancel anytime',
                isSecondary: true,
                isLoading: _isLoading,
                onTap: () => _purchase(true),
              ),

              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () async {
                    await RevenueCatService.restorePurchases();
                    if (await RevenueCatService.isPremium() && mounted) {
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('Restore purchases',
                    style: GoogleFonts.inter(
                      fontSize: 13, color: AppColors.textDisabled,
                      decoration: TextDecoration.underline)),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final String text;
  const _Feature(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(children: [
        const Icon(Icons.check_circle, size: 18, color: AppColors.accent),
        const SizedBox(width: 10),
        Expanded(child: Text(text,
          style: GoogleFonts.inter(fontSize: 15, color: AppColors.textPrimary))),
      ]),
    );
  }
}

class _PayButton extends StatefulWidget {
  final String label;
  final bool isSecondary;
  final bool isLoading;
  final VoidCallback onTap;

  const _PayButton({
    required this.label,
    this.isSecondary = false,
    required this.isLoading,
    required this.onTap,
  });

  @override
  State<_PayButton> createState() => _PayButtonState();
}

class _PayButtonState extends State<_PayButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : () {
        setState(() => _pressed = true);
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() => _pressed = false);
          widget.onTap();
        });
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: widget.isSecondary ? AppColors.surface : AppColors.accent,
            borderRadius: BorderRadius.circular(AppRadius.button),
            border: widget.isSecondary
                ? Border.all(color: AppColors.borderSubtle)
                : null,
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : Text(widget.label,
                    style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600,
                      color: widget.isSecondary ? AppColors.textPrimary : Colors.white)),
          ),
        ),
      ),
    );
  }
}
