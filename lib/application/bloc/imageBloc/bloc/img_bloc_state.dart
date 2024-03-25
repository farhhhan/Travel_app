part of 'img_bloc_bloc.dart';

 class ImgBlocState extends Equatable {
 const  ImgBlocState({ this.file});
  final XFile? file;
  ImgBlocState copyWith({XFile? file}){
    return  ImgBlocState(file: file ?? this.file);
  }
  @override
  List<Object?> get props => [file];
}

