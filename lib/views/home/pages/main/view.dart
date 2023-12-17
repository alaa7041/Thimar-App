import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/features/home/pages/cart/store/states.dart';
import '../../../../core/design/app_button.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_input.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../features/categories/bloc.dart';
import '../../../../features/categories/model.dart';
import '../../../../features/categories/states.dart';
import '../../../../features/home/pages/cart/get/bloc.dart';
import '../../../../features/products/bloc.dart';
import '../../../../features/sliders/bloc.dart';
import '../../../../features/sliders/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cart/view.dart';
import '../product_details/views.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late CartBloc bloc;
  late ProductModel model;

  @override
  void initState() {
    bloc = BlocProvider.of(context);
    bloc.add(CartEvents());
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MainAppBar(),
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
                                (index) =>
                                AppImage(
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
                              (index) =>
                              Padding(
                                  padding: EdgeInsetsDirectional.only(end: 3.w),
                                  child: CircleAvatar(
                                    radius: 4.r,
                                    backgroundColor: index == currentIndex
                                        ? Theme
                                        .of(context)
                                        .primaryColor
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
                        SizedBox(height: 16.h,),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16,
                          ),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    width: 16.w,
                                  ),
                              itemBuilder: (context, index) =>
                                  _ItemCategory(
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
              },),
            BlocBuilder<ProductBloc, ProductsStates>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductsSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h,),
                          const Text("الاصناف"),
                          SizedBox(height: 6.h,),
                          GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 163 / 250,
                            ),
                            itemBuilder: (context, index) =>
                                _ItemProduct(
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

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16).w,
      child: Row(
        children: [
          AppImage(
            path: "assets/images/logo.png",
            height: 21.h,
            width: 21.w,
            fit: BoxFit.scaleDown,
          ),
          SizedBox(
            width: 3.w,
          ),
          Text(
            "سلة ثمار",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: "التوصيل إلى",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                children: [
                  const TextSpan(
                    text: "\n",
                  ),
                  TextSpan(
                    text: "شارع الملك فهد - جدة",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              navigateTo(const CartView());
            },
            child: Badge(
              alignment: AlignmentDirectional.topStart,
              label: Text(
                "3",
                style: TextStyle(
                  fontSize: 6.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2).w,
              child: Container(
                height: 33.h,
                width: 33.w,
                padding: const EdgeInsets.all(7).w,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor
                      .withOpacity(.13),
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: SvgPicture.asset("assets/icons/svg/cart_icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}

class _ItemCategory extends StatelessWidget {
  final CategoryModel model;

  const _ItemCategory({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 73.w,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 73.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius
                    .circular(10)
                    .r,
                color: Colors.grey.withOpacity(.1),
              ),
              child: AppImage(
                path: model.media,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          SizedBox(height: 5.h,),
          Text(model.name),
        ],
      ),
    );
  }
}

class _ItemProduct extends StatelessWidget {
  final ProductModel model;
  final CartBloc bloc;


  const _ItemProduct({
    Key? key,
    required this.model,
    required this.bloc,

     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11.r),
              child: Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.topEnd,
                children: [
                  AppImage(
                    path: model.mainImage,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(11.r),
                          )
                      ),
                      child: Text(
                        "${model.discount}%",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
          ),
          SizedBox(height: 3.h,),
          Text(
            "السعر/ 1 ${model.unit.name}",
            style: TextStyle(color: const Color(0xff808080), fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 3.h,),
          Text.rich(
            TextSpan(
              text: "ر.س${model.price}",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(text: "\t "),
                TextSpan(text: "ر.س${model.priceBeforeDiscount}",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold)
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          SizedBox(
            height: 35.h,
            child: BlocBuilder(
              bloc: bloc,
              builder:  (context, state) {
                return AppButton(
                    text: "أضف للسلة",
                    onPress: () {
                      //print("${model.id}");
                      //bloc.add(StoreItemInCartEvent(amount: 1, productId:
                      //model.id,));
                    navigateTo(ProductDetails(model: model,));
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}