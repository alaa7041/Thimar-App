part of 'bloc.dart';

class SliderStates{}
class SliderLoadingState extends SliderStates{}
class SliderSuccessState extends SliderStates{
  final List<SliderModel> list;


  SliderSuccessState({required this.list});
}
class SliderFailedState extends SliderStates{
  final String msg;

  SliderFailedState({required this.msg});
}

