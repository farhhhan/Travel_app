import 'dart:async';
import 'dart:io';

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
  }

  FutureOr<void> _imageFromCamera(camerPickerEvent event, Emitter<ImgBlocState> emit)async {
    XFile? file=await imagePickUtils.getimageFromCamera();
    emit(state.copyWith(file: file));
  }
  FutureOr<void> _imageFromGallery(gellaryPickerEvent event, Emitter<ImgBlocState> emit)async {
    XFile? file=await imagePickUtils.getimageFromGellary();
    emit(state.copyWith(file: file));
  }
}
