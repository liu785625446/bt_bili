import 'package:bt_bili/http/core/bt_net.dart';
import 'package:bt_bili/http/request/profile_request.dart';
import 'package:bt_bili/models/profile_model.dart';

class ProfileDao {
  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await BtNet.getInstance().fire(request);
    return ProfileModel.fromJson(result['data']);
  }
}
