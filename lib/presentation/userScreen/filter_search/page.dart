import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/application/bloc/packageBloc/bloc/package_bloc.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/filter.dart';
import 'package:travel_app/presentation/userScreen/filter_search/widgets/package_card.dart';
import 'package:travel_app/presentation/userScreen/package/packageDetials.dart';

class filterPackageScreen extends StatefulWidget {
  const filterPackageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _filterPackageScreenState createState() => _filterPackageScreenState();
}

class _filterPackageScreenState extends State<filterPackageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Search trip",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Filter(),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<PackageBloc, PackageState>(
                  builder: (context, state) {
                    if (state is PackageLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    } else if (state is packageLoaded) {
                      return StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        children: [
                          Center(
                            child: Text(
                              "Found ${state.listPackages.length} results",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          for (var i = 0; i < state.listPackages.length; i++)
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PackageDetailScreen(
                                                  packageModel:
                                                      state.listPackages[i])));
                                },
                                child: PackageCard(
                                    packageModel: state.listPackages[i]))
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
