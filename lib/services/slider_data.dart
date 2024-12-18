import 'package:newsly/model/slider_mode.dart';

List<SliderModel> getSliders(){
  List <SliderModel> slider = [];
  SliderModel sliderModel = new SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "images/business.jpg";
  slider.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "images/entertainment.jpg";
  slider.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "images/general.jpg";
  slider.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "images/health.jpg";
  slider.add(sliderModel);
  sliderModel = new SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "images/sports.jpg";
  slider.add(sliderModel);
  sliderModel = new SliderModel();

  return slider;
}