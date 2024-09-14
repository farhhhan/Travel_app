import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/infrastructure/imageSearvice.dart';

part 'img_bloc_event.dart';
part 'img_bloc_state.dart';

class ImgBlocBloc extends Bloc<ImgBlocEvent, ImgBlocState> {
  final ImagePickerServices imagePickUtils;
  ImgBlocBloc(this.imagePickUtils) : super(ImgBlocState()) {
    on<camerPickerEvent>(_imageFromCamera);
    on<gellaryPickerEvent>(_imageFromGallery);
    on<SaveEvent>(_saveEvent);
  }

  FutureOr<void> _imageFromCamera(
      camerPickerEvent event, Emitter<ImgBlocState> emit) async {
    XFile? file = await imagePickUtils.getimageFromCamera();
    List<XFile> list = [];
    list.add(file!);
    emit(state.copyWith(file: list));
  }

  FutureOr<void> _imageFromGallery(
      gellaryPickerEvent event, Emitter<ImgBlocState> emit) async {
    XFile? file = await imagePickUtils.getimageFromGellary();
    List<XFile> list = [];
    list.add(file!);
    emit(state.copyWith(file: list));
  }

  FutureOr<void> _saveEvent(SaveEvent event, Emitter<ImgBlocState> emit) {
    emit(state.copyWith(file: []));
  }
}
