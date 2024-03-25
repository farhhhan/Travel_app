import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/imageBloc/bloc/img_bloc_bloc.dart';

class RegisterRepo{


  Future<dynamic> ShowBottoms(BuildContext context) {
    return showModalBottomSheet<dynamic>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return BlocBuilder<ImgBlocBloc, ImgBlocState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(camerPickerEvent());
                    },
                    leading: Icon(Icons.camera),
                    title: Text('Take Form Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      context.read<ImgBlocBloc>().add(gellaryPickerEvent());
                    },
                    leading: Icon(Icons.browse_gallery),
                    title: Text('Take Form Gellary'),
                  ),
                ],
              );
            },
          );
        });
  }}