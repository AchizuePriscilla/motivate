import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'viewmodels/motivate_vm.dart';

final motivateVM = ChangeNotifierProvider((_) => MotivateViewModel());
