import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_values.dart';
import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppValues.contentPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                /// Logo Animation
                _AnimatedFadeSlide(
                  opacity: controller.isLogoAnimated,
                  child: Image.asset('assets/icon/icon.png', height: 140, width: 140, fit: BoxFit.cover),
                ),

                const SizedBox(height: AppValues.contentPadding),

                /// Name Animation
                _AnimatedFadeSlide(
                  opacity: controller.isNameAnimated,
                  child: Text(
                    AppValues.userName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontFamily: 'FontBold'),
                  ),
                ),

                const Spacer(),

                /// Version
                _AnimatedFade(
                  opacity: controller.isVersionAnimated,
                  child: Text(
                    'Version: ${controller.globalValueController.version}',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontFamily: 'FontBold', color: Colors.grey.shade400),
                  ),
                ),

                /// Footer
                _AnimatedFade(
                  opacity: controller.isFooterAnimated,
                  child: Text(
                    AppValues.footer,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall!.copyWith(fontFamily: 'FontBold', color: Colors.grey.shade400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedFadeSlide extends StatelessWidget {
  final RxBool opacity;
  final Widget child;

  const _AnimatedFadeSlide({required this.opacity, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isVisible = opacity.value;

      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        opacity: isVisible ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          offset: isVisible ? const Offset(0, 0) : const Offset(0, 0.25),
          child: child,
        ),
      );
    });
  }
}

class _AnimatedFade extends StatelessWidget {
  final RxBool opacity;
  final Widget child;

  const _AnimatedFade({required this.opacity, required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedOpacity(duration: const Duration(milliseconds: 300), opacity: opacity.value ? 1 : 0, child: child);
    });
  }
}
