import 'package:flutter_test/flutter_test.dart';
import 'package:myfarm/features/tasks/domin/entities/user_role.dart';
import 'package:myfarm/features/tasks/presentation/view/tasks_page.dart';

void main() {
  test('maps firebase user type values to the correct user role', () {
    expect(userRoleFromFirebaseValue('farmer'), UserRole.farmer);
    expect(userRoleFromFirebaseValue('ENGINEER'), UserRole.engineer);
    expect(userRoleFromFirebaseValue('supervisor'), UserRole.supervisor);
    expect(userRoleFromFirebaseValue('owner'), UserRole.owner);
    expect(userRoleFromFirebaseValue(null), UserRole.farmer);
    expect(userRoleFromFirebaseValue('unknown'), UserRole.farmer);
  });
}
