import 'package:shinro_int2/models/news/categorie_model.dart';

List<CategorieModel> getCategories() {
  List<CategorieModel> myCategories = List<CategorieModel>();
  CategorieModel categorieModel;

  //1
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Phương pháp học";
  categorieModel.imageAssetUrl =
      "https://tiengnhat.minder.vn/wp-content/uploads/2017/09/ph%C6%B0%C6%A1ng-ph%C3%A1p-h%E1%BB%8Dc-ti%E1%BA%BFng-nh%E1%BA%ADt-cho-ng%C6%B0%E1%BB%9Di-m%E1%BB%9Bi-b%E1%BA%AFt-%C4%91%E1%BA%A7u-01.png";
  myCategories.add(categorieModel);

  //2
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Từ vựng";
  categorieModel.imageAssetUrl =
      "https://trungtamnhatngu.edu.vn/uploads/blog/2017_01/hoc-tu-vung-tieng-nhat.jpg";
  myCategories.add(categorieModel);

  //3
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Ngữ pháp";
  categorieModel.imageAssetUrl =
      "https://dulichsenxanh.vn/images/tour/6a1fd04668a1ada8777b28144ca3e889.jpg";
  myCategories.add(categorieModel);

  //4
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Giáo tiếp";
  categorieModel.imageAssetUrl =
      "https://lh3.googleusercontent.com/proxy/pAwSCdqfGQABSb0hGIzkZaAkaOcXgUM1--I6IBzIimB83FhZKTwwi54n03OXxYJkZGSjhie0PjSP_jmlqEPaBLZTVRqBJgbySAQuRNPFDUisK1kOc0DzX5KO1Hb7ZmkB2sFL5RCTnQ";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Luyện nghe";
  categorieModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Kanji";
  categorieModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  //5
  categorieModel = new CategorieModel();
  categorieModel.categorieName = "Technology";
  categorieModel.imageAssetUrl =
      "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80";
  myCategories.add(categorieModel);

  return myCategories;
}
