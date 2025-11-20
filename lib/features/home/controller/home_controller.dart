import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:http/http.dart' as http;
import 'package:sokrio_technologies_ltd/features/home/model/user_model.dart';
import '../../../core/api/api_endpoint.dart';
import '../../../core/routes/route.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/widgets/widget_snack_bar.dart' show WidgetSnackBar;
import '/core/values/global_values.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalValues globalValues = Get.find();
  final connectivityService = Get.find<ConnectivityService>();
  var isLoading = false.obs;

  final box = GetStorage();

  var repoModel = RepoModel().obs;
  var userList = <Data>[].obs;
  var filterUserList = <Data>[].obs;
  var userDetailsModel = Data().obs;

  TextEditingController searchController = TextEditingController();

  var pageIndex = 1.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        if (isLoading.value) {
        } else {
          if ((repoModel.value.totalPages ?? 0) > pageIndex.value) {
            pageIndex = pageIndex + 1;
            fetchUserRecord();
          }
        }
      }
    });

    if (connectivityService.hasNetwork.value) {
      loadOfflineData();
    } else {
      loadInitial();
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    searchController.dispose();
  }

  Future<void> loadInitial() async {
    try {
      isLoading.value = true;
      await fetchUserRecord();
    } catch (e) {
      WidgetSnackBar.show(context: Get.context!, title: "Failed", message: "Error $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reloadRecord() async {
    pageIndex.value = 1;
    userList.clear();
    filterUserList.clear();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(
          '${ApiEndpoint.baseURL}${ApiEndpoint.userRecordEndpoint}',
        ).replace(queryParameters: {'per_page': '10', 'page': pageIndex.value.toString()}),

        headers: {'x-api-key': 'reqres-free-v1', 'Content-Type': 'application/json', 'accept': 'application/json'},
      );

      debugPrint('${response.request}');
      //debugPrint('Response body : ${response.body}');
      //debugPrint("Status Code : ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        repoModel.value = RepoModel.fromJson(responseBody);

        List<dynamic> data = responseBody['data'] as List<dynamic>;

        for (var element in data) {
          userList.add(Data.fromJson(element));
          filterUserList.add(Data.fromJson(element));
        }

        cashOfflineData(userList);
      } else {
        final responseBody = jsonDecode(response.body);

        WidgetSnackBar.show(
          context: Get.context!,
          title: "Failed",
          message:
              responseBody['error'] ??
              (responseBody['errors'] as Map<String, dynamic>).values
                  .expand((e) => e) // flatten all lists
                  .join('\n'),
        );
      }
    } on SocketException {
      debugPrint("SocketException");

      rethrow;
    } on HttpException {
      debugPrint("HttpException");
      rethrow;
    } on FormatException {
      debugPrint("FormatException");
      rethrow;
    } on TimeoutException {
      debugPrint("TimeoutException");
      rethrow;
    } catch (e) {
      debugPrint("Exception : $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void goToDetailsScreen(Data data) {
    userDetailsModel.value = data;
    Get.toNamed(RouteService.userDetailsView);
  }

  void filterUser(String query) {
    filterUserList.clear();

    final search = query.toLowerCase();

    if (search.isNotEmpty) {
      final matchUsers = userList.where((user) {
        final first = (user.firstName ?? '').toLowerCase();
        final last = (user.lastName ?? '').toLowerCase();
        final email = (user.email ?? '').toLowerCase();

        return first.contains(search) || last.contains(search) || email.contains(search);
      }).toList();

      filterUserList.assignAll(matchUsers);
    } else {
      filterUserList.assignAll(userList.toList());
    }
  }

  void cashOfflineData(List<dynamic> data) {
    box.write('offline_user_cash', data);
  }

  void loadOfflineData() {
    final data = box.read('offline_user_cash');

    for (var element in data) {
      userList.add(Data.fromJson(element));
      filterUserList.add(Data.fromJson(element));
    }
  }
}
