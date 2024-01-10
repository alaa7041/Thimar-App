import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design/app_bar.dart';
import '../../../../features/home/pages/favorites/bloc.dart';
import 'components/item_favorites_product.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late FavoritesBloc bloc;
  late FavoritesModel model;

  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(FavoritesEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomAppBar(
            onPress: () {},
            text: 'المفضلة',
          ),
          Column(
            children: [
              BlocBuilder<FavoritesBloc, FavoritesStates>(
                builder: (context, state) {
                  if (state is FavoritesLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavoritesSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.w,
                              mainAxisSpacing: 10.h,
                              childAspectRatio: 163 / 250,
                            ),
                            itemBuilder: (context, index) => ItemFavoritesProduct(
                              model: state.list[index],
                              bloc: bloc,
                            ),
                            itemCount: state.list.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text("Failed");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}