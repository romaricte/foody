import 'package:myfoody/helpers/widgets/my_form_validator.dart';
import 'package:myfoody/views/my_controller.dart';

class SettingController extends MyController {
  MyFormValidator validation = MyFormValidator();
  bool showPassword = false;
  bool resetPasswordShow = false;

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeResetPasswordShow() {
    resetPasswordShow = !resetPasswordShow;
    update();
  }
}
