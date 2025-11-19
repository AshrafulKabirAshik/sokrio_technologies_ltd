import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'core/routes/route.dart';
import 'core/themes/theme.dart';
import 'core/utils/util.dart';
import 'core/values/global_values.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(GlobalValues());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final controller = Get.find<GlobalValues>();
    MaterialTheme theme = MaterialTheme(createTextTheme(context));

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'sokrio_technologies_ltd',
        theme: controller.isDarkMode.value ? theme.dark() : theme.light(),
        defaultTransition: Transition.native,
        initialRoute: RouteService.splashView,
        getPages: RouteService.pages,
      );
    });
  }
}
