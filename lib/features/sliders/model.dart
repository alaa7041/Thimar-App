class SliderData {

  late final List<SliderModel> list;

  SliderData .fromJson(Map<String, dynamic> json){
    list = List.from(json['data']??[]).map((e)=> SliderModel.fromJson(e))
        .toList();
  }
}

class  SliderModel {
  SliderModel({
    required this.id,
    required this.media,
  });
  late final int id;
  late final String media;

  SliderModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    media = json['media'];
  }
}