import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/application/bloc/faverot/bloc/favoret_bloc.dart';
import 'package:travel_app/domain/packageModel/packageModel.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/filter.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/package_card.dart';
import 'package:travel_app/presentation/userScreen/wishlist/widget/filterwish.dart';

class WishScreen extends StatefulWidget {
  const WishScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WishScreenState createState() => _WishScreenState();
}


class _WishScreenState extends State<WishScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FavoretBloc>().add(GetWishEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Wish  Package",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const FilterWish(),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<FavoretBloc, FavoretState>(
                  builder: (context, state) {
                    if (state is WishLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WishLoadedState) {
                      return StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        children: [
                          Center(
                            child: Text(
                              "Found ${state.listWish.length} results",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (var i = 0; i < state.listWish.length; i++)
                            InkWell(
                                onTap: () {
                                  print(state.listWish[i].packageModel['imageUrlList'],);
                                },
                                child: PackageCard(
                                  imageUrl:state.listWish[i].packageModel['imageUrlList'][0],
                                    packageModel: PackageModel.fromJson(
                                        state.listWish[i].packageModel)))
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
