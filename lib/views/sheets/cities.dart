import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/get_cities/bloc.dart';

class CitiesSheet extends StatefulWidget {
  const CitiesSheet({Key? key}) : super(key: key);
  @override
  State<CitiesSheet> createState() => _CitiesSheetState();
}
class _CitiesSheetState extends State<CitiesSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          Text(
            "اختر بلدك",
            style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp,
            ),
          ),
          BlocBuilder<GetCitiesBloc,GetCitiesStates>(

            builder: (context, state) {
              if(state is GetCitiesLoadingState){
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else if (state is GetCitiesSuccessState){
                return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemBuilder: (context, index) =>
                          _Item(
                            model:state.list[index],
                          ),
                      itemCount: state.list.length,
                    ));
              }else{
                return const Text("Failed");
              }
            },
          ),
        ],
      ),
    );
  }
}

//Coustom widght
class _Item extends StatelessWidget {
  final CitiesModel model;

  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, model);
        //print(model.name);
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.only(bottom: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.r),
            color: Theme
                .of(context)
                .primaryColor
                .withOpacity(.1)),
        child: Center(
          child: Text(
            model.name,
          ),
        ),
      ),
    );
  }
}
