import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_values.dart';
import '../controller/home_controller.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              SizedBox(height: AppValues.contentPadding * 2),
              Hero(
                tag: controller.userDetailsModel.value.id.toString(),
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: controller.globalValues.isDarkMode.value ? Colors.white : Colors.black,
                  backgroundImage: Image.network(controller.userDetailsModel.value.avatar ?? '').image,
                ),
              ),
              SizedBox(height: AppValues.contentPadding * 2),
              Text(
                '${controller.userDetailsModel.value.firstName?.toString() ?? ''} ${controller.userDetailsModel.value.lastName?.toString() ?? ''}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontFamily: 'FontBold'),
              ),

              Text(
                controller.userDetailsModel.value.email?.toString() ?? '',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontFamily: 'FontBold', color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
