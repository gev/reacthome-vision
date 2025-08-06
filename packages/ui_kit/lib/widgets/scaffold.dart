import 'package:flutter/widgets.dart';

typedef ScaffoldFactory<T extends Widget> =
    Widget Function({T? appBar, required Widget body});
