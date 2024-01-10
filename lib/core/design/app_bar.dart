import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/home/pages/favorites/addToFavorites/bloc.dart';

class CustomAppBar extends StatefulWidget {
  final bool isFavorite;
  final String text;
  final VoidCallback onPress;

  const CustomAppBar({
    Key? key,
    this.isFavorite = false,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToFavoritesBloc(),
      child: Builder(
        builder: (context) {
          AddToFavoritesBloc bloc = BlocProvider.of(context);
          return AppBar(
            title: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(9.5),
              child: Container(
                width: 36.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: widget.onPress,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(9.5),
                child: widget.isFavorite
                    ? Container(
                        width: 36.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: BlocBuilder<AddToFavoritesBloc,AddToFavoritesStates>(
                          builder: (context, state) {
                            return IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                bloc.add(AddToFavoritesEvent(isFavorites: 
                                true, productId: 2,));
                              },
                            );
                          },
                        ),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
