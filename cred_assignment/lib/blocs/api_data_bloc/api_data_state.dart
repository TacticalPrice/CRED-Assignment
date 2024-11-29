import 'package:flutter/material.dart';


@immutable
abstract class ApiDataState {}


class ApiDataInitial extends ApiDataState {}


class ApiDataLoading extends ApiDataState {}


class ApiDataSuccess extends ApiDataState {
 final Map<String, dynamic> data;


 ApiDataSuccess(this.data);
}


class ApiDataError extends ApiDataState {
 final String message;


 ApiDataError(this.message);
}
