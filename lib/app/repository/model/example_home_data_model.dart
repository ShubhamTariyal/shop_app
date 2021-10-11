///Example of model

// class HomePageModel {
//   late List<HomePageResponseModel>? mobileEn;

//   late List<HomePageResponseModel>? mobileAr;

//   late List<HomeCollectEng>? homeCollectEn;

//   late List<HomeCollectEng>? homeCollectAr;

//   late List<TermsAndConditionsEng>? termsAndConditionsEn;

//   late List<TermsAndConditionsEng>? termsAndConditionsAr;

//   late List<PrivacyPoliciesEng>? privacyPoliciesEn;

//   late List<PrivacyPoliciesEng>? privacyPoliciesAr;
// }

// class HomePageResponseModel {
//   int? id;

//   String? locale;

//   String? publishedAt;

//   String? createdAt;

//   String? updatedAt;

//   String? youtubeVideo;

//   List<RecentDeal>? recentDeals;

//   List<TestimonialsModel>? testimonials;

//   HomepageModel? homepage;

//   WatchesLandingModel? watchesLanding;

//   BagsLandingModel? bagsLanding;

//   CarsLandingModel? carsLanding;

//   List<dynamic>? localizations;

//   HomePageResponseModel({
//     this.id,
//     this.locale,
//     this.publishedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.youtubeVideo,
//     this.recentDeals,
//     this.testimonials,
//     this.homepage,
//     this.watchesLanding,
//     this.bagsLanding,
//     this.carsLanding,
//     this.localizations,
//   });
// }

// class TestimonialsModel {
//   int? id;
//   String? name;
//   String? rating;
//   String? comment;
//   String? page;
//   String? profilePic;

//   TestimonialsModel({
//     required this.id,
//     required this.name,
//     required this.rating,
//     required this.comment,
//     required this.page,
//     required this.profilePic,
//   });
// }

// class HomepageModel {
//   int? id;

//   List<HowItWorksModel> howItWorks;

//   List<WhyNorthLadderModel> whyNorthLadder;

//   HomepageModel(
//     this.id,
//     this.howItWorks,
//     this.whyNorthLadder,
//   );
// }

// class HowItWorksModel {
//   int? id;
//   String title;
//   String description;
//   IconModel? icon;
//   HowItWorksModel(
//     this.id,
//     this.title,
//     this.description,
//     this.icon,
//   );
// }

// class IconModel {
//   int? id;

//   String name;

//   String alternativeText;
//   String caption;

//   int? width;

//   int? height;

//   String hash;
//   String ext;

//   String mime;

//   double size;

//   String url;
//   String provider;

//   String createdAt;

//   String updatedAt;

//   IconModel(
//     this.id,
//     this.name,
//     this.alternativeText,
//     this.caption,
//     this.width,
//     this.height,
//     this.hash,
//     this.ext,
//     this.mime,
//     this.size,
//     this.url,
//     this.provider,
//     this.createdAt,
//     this.updatedAt,
//   );
// }

// class WhyNorthLadderModel {
//   int? id;

//   String title;

//   String description;

//   IconModel? icon;

//   WhyNorthLadderModel(
//     this.id,
//     this.title,
//     this.description,
//     this.icon,
//   );
// }

// class WatchesLandingModel {
//   int? id;

//   List<SliderModel> slider;

//   List<HowDoesItWorksModel> howDoesItWorks;

//   List<WhyNorthLadderModel> whyNorthLadder;

//   List<BrandsModel> brands;

//   List<VideosModel> videos;

//   WatchesLandingModel(
//     this.id,
//     this.slider,
//     this.howDoesItWorks,
//     this.whyNorthLadder,
//     this.brands,
//     this.videos,
//   );
// }

// class SliderModel {
//   int? id;

//   String title;

//   String description;

//   String buttonText;

//   ImgModel img;

//   SliderModel(
//     this.id,
//     this.title,
//     this.description,
//     this.buttonText,
//     this.img,
//   );
// }

// class ImgModel {
//   int? id;

//   String? name;

//   String? alternativeText;

//   String? caption;

//   int? width;

//   int? height;

//   // FormatsModel? formats;

//   String? hash;

//   String? ext;

//   String? mime;

//   double? size;

//   String? url;

//   String? provider;

//   String? createdAt;

//   String? updatedAt;

//   ImgModel(
//     this.id,
//     this.name,
//     this.alternativeText,
//     this.caption,
//     this.width,
//     this.height,
//     // this.formats,
//     this.hash,
//     this.ext,
//     this.mime,
//     this.size,
//     this.url,
//     this.provider,
//     this.createdAt,
//     this.updatedAt,
//   );
// }

// class FormatsModel {
//   SmallModel? small;

//   ThumbnailModel? thumbnail;

//   FormatsModel(
//     this.small,
//     this.thumbnail,
//   );
// }

// class SmallModel {
//   String ext;

//   String url;

//   String hash;

//   String mime;

//   String name;

//   double size;

//   int? width;

//   int? height;

//   SmallModel(
//     this.ext,
//     this.url,
//     this.hash,
//     this.mime,
//     this.name,
//     this.size,
//     this.width,
//     this.height,
//   );
// }

// class ThumbnailModel {
//   String? ext;

//   String? url;

//   String? hash;

//   String? mime;

//   String? name;

//   double? size;

//   int? width;

//   int? height;

//   ThumbnailModel(
//     this.ext,
//     this.url,
//     this.hash,
//     this.mime,
//     this.name,
//     this.size,
//     this.width,
//     this.height,
//   );
// }

// class HowDoesItWorksModel {
//   int? id;

//   String title;

//   String description;

//   IconModel? icon;

//   HowDoesItWorksModel(
//     this.id,
//     this.title,
//     this.description,
//     this.icon,
//   );
// }

// class BrandsModel {
//   int? id;

//   ImgModel img;

//   BrandsModel(
//     this.id,
//     this.img,
//   );
// }

// class VideosModel {
//   int? id;

//   String url;

//   VideosModel(
//     this.id,
//     this.url,
//   );
// }

// class BagsLandingModel {
//   int? id;

//   String title;

//   String description;

//   List<HowItWorksModel> howItWorks;

//   List<WhyNorthLadderModel> whyNorthLadder;

//   List<BrandsModel> brands;

//   OffersDescriptionModel offersDescription;

//   List<DaysModel> days;

//   ImgModel img;

//   BagsLandingModel(
//     this.id,
//     this.title,
//     this.description,
//     this.howItWorks,
//     this.whyNorthLadder,
//     this.brands,
//     this.offersDescription,
//     this.days,
//     this.img,
//   );
// }

// class OffersDescriptionModel {
//   int? id;

//   String title;

//   String description;

//   String bottomDescription;

//   OffersDescriptionModel(
//     this.id,
//     this.title,
//     this.description,
//     this.bottomDescription,
//   );
// }

// class DaysModel {
//   int? id;

//   String value;

//   String day;

//   DaysModel(
//     this.id,
//     this.value,
//     this.day,
//   );
// }

// class CarsLandingModel {
//   int? id;

//   String agreedDescription;

//   String agreedDescriptionTitle;

//   String video;

//   List<SliderModel> slider;

//   List<BrandsModel> brands;

//   HowWeWorkModel howWeWork;

//   List<HowWorksModel> howWorks;

//   WhyNorthLadderDescriptionModel whyNorthLadderDescription;

//   List<WhyNorthLadderModel> whyNorthLadder;

//   CarsLandingModel(
//     this.id,
//     this.agreedDescription,
//     this.agreedDescriptionTitle,
//     this.video,
//     this.slider,
//     this.brands,
//     this.howWeWork,
//     this.howWorks,
//     this.whyNorthLadderDescription,
//     this.whyNorthLadder,
//   );
// }

// class HowWeWorkModel {
//   int? id;

//   String title;

//   String description;

//   HowWeWorkModel(
//     this.id,
//     this.title,
//     this.description,
//   );
// }

// class HowWorksModel {
//   int? id;

//   String title;

//   String description;

//   ImgModel img;

//   HowWorksModel(
//     this.id,
//     this.title,
//     this.description,
//     this.img,
//   );
// }

// class WhyNorthLadderDescriptionModel {
//   int? id;

//   String title;

//   String subtitle;

//   String description;

//   ImgModel img;

//   WhyNorthLadderDescriptionModel(
//     this.id,
//     this.title,
//     this.subtitle,
//     this.description,
//     this.img,
//   );
// }

// class RecentDeal extends Object {
//   int? id;

//   String? title;

//   String? price;

//   String? page;

//   List<Feature>? features;

//   String? imgUrl;

//   RecentDeal(
//     this.id,
//     this.title,
//     this.price,
//     this.page,
//     this.features,
//     this.imgUrl,
//   );
// }

// class Feature {
//   int? id;

//   String? description;

//   Feature(
//     this.id,
//     this.description,
//   );
// }

// class HomeCollectEng {
//   int id;

//   String locale;

//   String publishedAt;

//   String createdAt;

//   String updatedAt;

//   List<HomeCollect> homeCollect;


//   HomeCollectEng(
//     this.id,
//     this.locale,
//     this.publishedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.homeCollect,
//   );
// }

// class HomeCollect {
//   int id;

//   String title;

//   String description;

//   IconModel icon;

//   HomeCollect(
//     this.id,
//     this.title,
//     this.description,
//     this.icon,
//   );
// }

// class Localization {
//   int id;

//   String locale;

//   String publishedAt;

//   Localization(
//     this.id,
//     this.locale,
//     this.publishedAt,
//   );
// }

// class TermsAndConditionsEng {
//   int id;

//   String tnc;

//   String locale;

//   String publishedAt;

//   String createdAt;

//   String updatedAt;

//   List<Localization>? localizations;

//   TermsAndConditionsEng(
//     this.id,
//     this.tnc,
//     this.locale,
//     this.publishedAt,
//     this.createdAt,
//     this.updatedAt,
//   );
// }
// class PrivacyPoliciesEng {

//   int id;

//   String title;

//   String description;

//   String locale;

//   String publishedAt;

//   String createdAt;

//   String updatedAt;

//   List<Localization>? localizations;

//   PrivacyPoliciesEng(this.id,this.title,this.description,this.locale,this.publishedAt,this.createdAt,this.updatedAt,);

// }