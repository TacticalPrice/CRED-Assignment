import 'package:flutter/material.dart';


@immutable
abstract class TestMintState {}


class TestMintInitial extends TestMintState {}


class TestMintLoading extends TestMintState {}


class TestMintSuccess extends TestMintState {
 final Map<String, dynamic> data;


 TestMintSuccess(this.data);
}


class TestMintError extends TestMintState {
 final String message;


 TestMintError(this.message);
}
