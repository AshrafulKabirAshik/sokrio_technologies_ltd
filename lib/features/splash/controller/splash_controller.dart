import '../../../core/routes/route.dart';
import '/core/values/global_values.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final GlobalValues globalValueController = Get.find();

  /// Reactive states
  final isLogoAnimated = false.obs;
  final isNameAnimated = false.obs;
  final isVersionAnimated = false.obs;
  final isFooterAnimated = false.obs;

  /// Animation timings (easy to adjust)
  static const _logoDelay = Duration(milliseconds: 300);
  static const _nameDelay = Duration(milliseconds: 300);
  static const _versionDelay = Duration(milliseconds: 300);
  static const _footerDelay = Duration(milliseconds: 300);

  bool _isDisposed = false;

  @override
  void onInit() {
    super.onInit();
    _startAnimationSequence();
  }

  @override
  void onClose() {
    _isDisposed = true;
    super.onClose();
  }

  Future<void> _startAnimationSequence() async {
    await _animateStep(_logoDelay, isLogoAnimated);
    await _animateStep(_nameDelay, isNameAnimated);
    await _animateStep(_versionDelay, isVersionAnimated);
    await _animateStep(_footerDelay, isFooterAnimated);

    await Future.delayed(Duration(milliseconds: 500));

    _goToNextScreen();
  }

  Future<void> _animateStep(Duration delay, RxBool target) async {
    await Future.delayed(delay);
    if (!_isDisposed) target.value = true;
  }

  void _goToNextScreen() {
    if (!_isDisposed) {
      Get.offNamed(RouteService.homeView);
    }
  }
}
