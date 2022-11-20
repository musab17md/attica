String urlMain = '192.168.0.142:8123';
String urlModel = "http://$urlMain/all/product/Productmodel/";
String urlProd = "http://$urlMain/all/product/Productpic/";
String urlVideo = "http://$urlMain/all/product/Productvideo/";
String urlPhoto = "http://$urlMain/photo/";
String urlAuth = "http://$urlMain/auth/";
String urlNoti = "http://$urlMain/noti/";
String dataListUrl = "http://$urlMain/api/datalist/";

Uri addPics = Uri.parse('http://$urlMain/pics/');

Uri listPics = Uri.http(urlMain, '/pics/');
Uri listProd = Uri.http(urlMain, '/noti/');
Uri currentUserUrl = Uri.http(urlMain, '/currentuser/');
Uri urlUsers = Uri.http(urlMain, '/users/');
Uri urlGold = Uri.http(urlMain, '/gold/');
