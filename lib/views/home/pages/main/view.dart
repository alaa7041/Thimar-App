import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_input.dart';
import '../../../../features/categories/bloc.dart';
import '../../../../features/home/pages/cart/store/bloc.dart';
import '../../../../features/products/bloc.dart';
import '../../../../features/sliders/bloc.dart';
import 'components/item_category.dart';
import 'components/item_product.dart';
import 'components/main_app_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StoreBloc bloc;
  late ProductModel model;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(StoreItemInCartEvents());
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  const MainAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const AppInput(
              icon: "assets/icons/svg/cart_icon.svg",
              hintText: "ابحث عن ماتريد؟",
            ),
            BlocBuilder<SliderBloc, SliderStates>(
              builder: (context, state) {
                if (state is SliderLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SliderSuccessState) {
                  return Column(
                    children: [
                      CarouselSlider(
                        items: List.generate(
                            state.list.length,
                            (index) => AppImage(
                                  path: state.list[index].media,
                                  fit: BoxFit.fill,
                                  height: 164.h,
                                  width: double.infinity,
                                )),
                        options: CarouselOptions(
                          height: 164.h,
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            currentIndex = index;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.list.length,
                          (index) => Padding(
                              padding: EdgeInsetsDirectional.only(end: 3.w),
                              child: CircleAvatar(
                                radius: 4.r,
                                backgroundColor: index == currentIndex
                                    ? Theme.of(context).primaryColor
                                    : const Color(0xff61880c),
                              )),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text("Failed");
                }
              },
            ),
            BlocBuilder<CategoriesBloc, CategoriesStates>(
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoriesSuccessState) {
                  return SizedBox(
                    height: 139.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                          child: Text(
                            "الاقسام",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Expanded(
                            child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16.w),
                          itemBuilder: (context, index) => ItemCategory(
                            model: state.list[index],
                          ),
                          itemCount: state.list.length,
                          scrollDirection: Axis.horizontal,
                        )),
                      ],
                    ),
                  );
                } else {
                  return const Text("Failed");
                }
              },
            ),
            BlocBuilder<ProductBloc, ProductsStates>(builder: (context, state) {
              if (state is ProductsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductsSuccessState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      const Text("الاصناف"),
                      SizedBox(height: 6.h),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 163 / 250,
                        ),
                        itemBuilder: (context, index) => ItemProduct(
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
            }),
          ],
        ),
      ),
    );
  }
}