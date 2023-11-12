import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design/app_button.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_input.dart';
import '../../../../core/logic/cashe_helper.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../features/categories/bloc.dart';
import '../../../../features/categories/model.dart';
import '../../../../features/categories/states.dart';
import '../../../../features/products/bloc.dart';
import '../../../../features/products/model.dart';
import '../../../../features/products/states.dart';
import '../../../../features/sliders/bloc.dart';
import '../../../../features/sliders/states.dart';
import '../../../auth/login/view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cart/view.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MainAppBar(),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            AppInput(
              icon: "assets/icons/svg/cart_icon.svg",
              hintText: "ابحث عن ماتريد؟",
            ),
            BlocBuilder<SliderBloc, SliderStates>(
              builder: (context, state) {
                if (state is SliderLoadingState) {
                  return Center(
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
                                  state.list[index].media,
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
                                        : Color(0xff61880c),
                                  )),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text("Failed");
                }
              },
            ),
            BlocBuilder<CategoriesBloc,CategoriesStates>(
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return Center(
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
                          padding: EdgeInsetsDirectional.symmetric(
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
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    width: 16.w,
                                  ),
                              itemBuilder: (context, index) =>
                                  _ItemCategory(
                                    model:state.list[index],
                                  ),
                              itemCount:state.list.length,
                              scrollDirection: Axis.horizontal,
                            )),
                      ],
                    ),
                  );
                } else {
                  return Text("Failed");
                }
            },),
            BlocBuilder<ProductBloc,ProductsStates>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ProductsSuccessState) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h,),
                          Text("الاصناف"),
                          SizedBox(height: 6.h,),
                          GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 163/250,
                            ),
                            itemBuilder: (context, index) => _ItemProduct(
                              model: state.list[index],
                            ),
                            itemCount: state.list.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text("Failed");
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
      padding: EdgeInsets.symmetric(horizontal: 16).w,
      child: Row(
        children: [
          AppImage(
            "assets/images/logo.png",
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
                  TextSpan(
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
              CasheHelper.clear();
              navigateTo(CartView());
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
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2).w,
              child: Container(
                height: 33.h,
                width: 33.w,
                padding: EdgeInsets.all(7).w,
                child: SvgPicture.asset("assets/icons/svg/cart_icon.svg"),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor
                      .withOpacity(.13),
                  borderRadius: BorderRadius.circular(9.r),
                ),
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
    return Container(
      width: 73.w,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 73.w,

              //padding: EdgeInsets.all(14),
              child: AppImage(
                model.media,
                fit: BoxFit.scaleDown,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10).r,
                color: Colors.grey.withOpacity(.1),
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
  const _ItemProduct({Key? key, required this.model,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9).w,
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
                      model.mainImage,
                      fit: BoxFit.cover,
                    ),
                   Align(
                     alignment: AlignmentDirectional.topEnd,
                     child:  Container(
                       padding: EdgeInsets.symmetric(
                         horizontal: 10.h,
                         vertical: 3,
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
                       decoration: BoxDecoration(
                           color: Theme.of(context).primaryColor,
                           borderRadius: BorderRadiusDirectional.only(
                             bottomStart: Radius.circular(11.r),
                           )
                       ),
                     ),
                   )

                  ],
                ),
          ),
          ),
          SizedBox(height: 3.h,),
          Text(
            "${model.title}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 3.h,),
          Text(
            "السعر/ 1 ${model.unit.name}",
            style: TextStyle(color: Color(0xff808080),fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 3.h,),
          Text.rich(TextSpan(
            text: "ر.س${model.price}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: "\t "),
              TextSpan(text: "ر.س${model.priceBeforeDiscount}",
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)
              ),
            ],
          ),
          ),
          SizedBox(height: 16.h,),
          SizedBox(
            height: 35.h,
            child: AppButton(
              text: 'أضف الى السلة',
              onPress: (){},
            ),
          )
        ],
      ) ,
    );
  }
}