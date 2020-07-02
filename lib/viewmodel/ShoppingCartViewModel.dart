
import 'package:journeywest/model/Role.dart';
import 'package:journeywest/viewmodel/BaseModel.dart';

class ShoppingCartViewModel extends BaseModel {
    List<Role> roles = List<Role>();

    ShoppingCartViewModel() {
      roles.add(Role(name: 'Wukong'));
      roles.add(Role(name: 'Sugar Tank'));
    }

}