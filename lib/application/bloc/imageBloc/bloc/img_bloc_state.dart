part of 'img_bloc_bloc.dart';

 class ImgBlocState extends Equatable {
 const  ImgBlocState({ this.file});
  final List<XFile>? file;
  ImgBlocState copyWith({List<XFile>? file}){
    return  ImgBlocState(file: file ?? this.file);
  }
  @override
  List<Object?> get props => [file];
}

