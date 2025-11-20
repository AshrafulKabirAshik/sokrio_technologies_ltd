import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widgets/widget_card.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return KeyboardDismisser(
      gestures: [GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          title: Text('User'),
          actions: [
            Obx(() {
              return Row(
                children: [
                  const SizedBox(width: AppValues.contentPadding),
                  Icon(controller.globalValues.isDarkMode.value ? Icons.dark_mode : Icons.light_mode, size: 16),
                  const SizedBox(width: AppValues.contentPadding),
                  Switch(
                    value: controller.globalValues.isDarkMode.value,
                    onChanged: (value) {
                      controller.globalValues.toggleBrightness(value);
                    },
                  ),
                  const SizedBox(width: AppValues.contentPadding),
                ],
              );
            }),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.only(left: AppValues.contentPadding, right: AppValues.contentPadding, bottom: AppValues.contentPadding),
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: controller.searchController,
                  style: Theme.of(context).textTheme.labelLarge,
                  onSubmitted: (value) {
                    controller.filterUser(value);
                  },
                  onChanged: (value) {
                    controller.filterUser(value);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: controller.globalValues.isDarkMode.value ? Colors.white10 : Colors.grey.shade200,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search...",
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppValues.contentPadding),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Obx(() {
          return RefreshIndicator(
            onRefresh: controller.connectivityService.hasNetwork.value
                ? () async {
                    print('offline_mode');
                  }
                : controller.reloadRecord,
            color: controller.globalValues.isDarkMode.value ? Colors.black : Colors.white,
            backgroundColor: controller.globalValues.isDarkMode.value ? Colors.white : Colors.black,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: ListView.builder(
                controller: controller.scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 2, bottom: 100),
                itemCount: controller.filterUserList.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.filterUserList.length) {
                    return Obx(() {
                      return controller.isLoading.value
                          ? Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, strokeCap: StrokeCap.round)),
                                    SizedBox(width: AppValues.contentPadding),
                                    Text('Loading...', style: Theme.of(context).textTheme.labelSmall!.copyWith()),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  controller.filterUserList.isEmpty ? 'No data found !' : 'No more data',
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),
                                ),
                              ),
                            );
                    });
                  }
                  final user = controller.filterUserList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: AppValues.contentPadding, right: AppValues.contentPadding, top: AppValues.contentPadding),
                    child: WidgetCard(
                      isDarkMode: controller.globalValues.isDarkMode.value,
                      cardType: CardType.outline,
                      color: Colors.grey.shade200,
                      child: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: AppValues.contentPadding / 2, right: AppValues.contentPadding),
                              child: Hero(
                                tag: user.id.toString(),
                                child: CircleAvatar(
                                  backgroundColor: controller.globalValues.isDarkMode.value ? Colors.white : Colors.black,
                                  child: ClipOval(
                                    child: Image.network(
                                      user.avatar ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.person,
                                          size: 16,
                                          color: controller.globalValues.isDarkMode.value ? Colors.black : Colors.white,
                                        );
                                      },
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(child: CircularProgressIndicator(strokeWidth: 1.5));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${user.firstName?.toString() ?? ''} ${user.lastName?.toString() ?? ''}',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontFamily: 'FontBold'),
                                  ),
                                  Text(
                                    user.email?.toString() ?? '',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontFamily: 'FontBold', color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppValues.contentPadding),
                        Align(
                          alignment: Alignment.centerRight,
                          child: WidgetCard(
                            isDarkMode: controller.globalValues.isDarkMode.value,
                            cardType: CardType.outline,
                            borderRadius: AppValues.childCornerRadius,
                            onTap: () {
                              controller.goToDetailsScreen(user);
                            },
                            child: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('View Profile', style: Theme.of(context).textTheme.labelMedium!.copyWith(fontFamily: 'FontBold')),
                                  SizedBox(width: AppValues.contentPadding / 2),
                                  Icon(Icons.arrow_forward, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
