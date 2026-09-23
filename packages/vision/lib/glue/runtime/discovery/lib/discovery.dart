import 'dart:io';

import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/discovery_store.dart';

Ir discovery(DiscoveryStore store) => IrNativeFunc(
  (Ir arg) => getRuntime().bind((runtime) {
    final address = getFromContext<InternetAddress>(runtime.context)?.address;
    if (address != null) {
      switch (arg) {
        case (IrObject(properties: final discoveryProps)):
          final version = toInt(discoveryProps['version']);
          if (version != 1) {
            return throwError(
              (wrongArgumentType(['Unknown discovery version protocol'])),
            );
          }
          final service = discoveryProps['service'];
          switch (service) {
            case (IrObject(:final properties)):
              final serviceProps = properties.unlock;
              final id = toString(serviceProps['id']);
              if (id == null) {
                return throwError(
                  (wrongArgumentType(['Service property `id` required'])),
                );
              }
              final scheme = toString(serviceProps['scheme']);
              if (scheme == null) {
                return throwError(
                  (wrongArgumentType(['Service property `scheme` required'])),
                );
              }
              final port = toInt(serviceProps['port']);
              if (port == null) {
                return throwError(
                  (wrongArgumentType(['Service property `port` required'])),
                );
              }
              final uri = toString(serviceProps['uri']) ?? '/';
              final url = '$scheme://$address:$port$uri';
              serviceProps['url'] = IrString(url);
              store.addService(id, IrObject(serviceProps));
            default:
              return throwError(
                (wrongArgumentType(['Service property should be an Object'])),
              );
          }
        default:
          return throwError(
            (wrongArgumentType(['Object properties required'])),
          );
      }
    }
    return Eval.pure(IrVoid());
  }),
);
