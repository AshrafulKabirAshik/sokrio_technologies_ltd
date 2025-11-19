import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sokrio_technologies_ltd/features/home/model/user_model.dart';
import '../../../core/api/api_endpoint.dart';
import '../../../core/routes/route.dart';
import '../../../core/widgets/widget_snack_bar.dart' show WidgetSnackBar;
import '/core/values/global_values.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalValues globalValues = Get.find();
  var isLoading = false.obs;

  var repoModel = RepoModel().obs;
  var userList = <Data>[].obs;
  var userDetailsModel = Data().obs;

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

    loadInitial();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
        }
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
}
