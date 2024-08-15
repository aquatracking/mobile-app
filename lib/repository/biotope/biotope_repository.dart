import 'dart:typed_data';

import 'package:aquatracking/models/biotope/biotope_model.dart';
import 'package:aquatracking/models/biotope/create_biotope_model.dart';
import 'package:aquatracking/models/measurementSubscription/measurement_subscription_model.dart';
import 'package:aquatracking/repository/repository.dart';
import 'package:dio/dio.dart';

abstract class BiotopeRepository<T extends BiotopeModel,
    CreateT extends CreateBiotopeModel> extends Repository {
  BiotopeRepository({
    required this.biotopeType,
    required this.fromJson,
  });

  final String biotopeType;
  final T Function(Map<String, dynamic>) fromJson;

  Future<List<T>> getList() async {
    Response<dynamic> response = await Repository.dio.get(
      "/$biotopeType",
    );
    List<T> aquariums =
        response.data.map<T>((data) => this.fromJson(data)).toList();

    return aquariums;
  }

  Future<T> create(CreateBiotopeModel biotope) async {
    Response<dynamic> response = await Repository.dio.post(
      "/$biotopeType",
      data: biotope.toJson(),
    );

    return this.fromJson(response.data);
  }

  Future<Uint8List?> getImage(BiotopeModel biotope) async {
    Response response = await Repository.dio.get(
      "/$biotopeType/${biotope.id}/image",
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.data == null || response.data.isEmpty) {
      return null;
    }

    return response.data;
  }

  Future<List<MeasurementSubscriptionModel>> getMeasurementSubscriptions(
      BiotopeModel biotope) async {
    Response<dynamic> response = await Repository.dio.get(
      "/$biotopeType/${biotope.id}/measurements/subscriptions/",
    );

    List<MeasurementSubscriptionModel> measurementSubscriptions = response.data
        .map<MeasurementSubscriptionModel>(
            (data) => MeasurementSubscriptionModel.fromJson(data))
        .toList();

    return measurementSubscriptions;
  }
}
