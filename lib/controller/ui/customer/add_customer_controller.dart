import 'package:myfoody/helpers/widgets/my_form_validator.dart';
import 'package:myfoody/views/my_controller.dart';

enum Country {
  UnitedState,
  Canada,
  Australia,
  Germany,
  Bangladesh,
  China,
  Bharat,
  Brazil;

  const Country();
}

enum StateName {
  Assam,
  Bihar,
  Chhattisgarh,
  Goa,
  Gujarat,
  Kerala,
  Mizoram;

  const StateName();
}

class AddCustomerController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
}
