import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/application/bloc/faverot/bloc/favoret_bloc.dart';

class FilterWish extends StatelessWidget {
  const FilterWish({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                context
                    .read<FavoretBloc>()
                    .add(searchEvent(searchQuery: value));
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: "Search place",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 22,
                  color: Colors.black,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
    );
  }
}
