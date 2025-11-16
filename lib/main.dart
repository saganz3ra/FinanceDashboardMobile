import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'presentation/controllers/dashboard_controller.dart';
import 'presentation/controllers/auth_controller.dart';
import 'routes/app_routes.dart';
import 'di/injection_container.dart' as di;

Future<void> main() async {
  // Use the same Zone for binding initialization and runApp to avoid "Zone mismatch".
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Inicializa o Firebase antes de registrar dependências que usam Firebase
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } catch (e, s) {
        debugPrint('Erro ao inicializar Firebase: $e');
        debugPrintStack(stackTrace: s);
        rethrow;
      }

      try {
        await di.init();
      } catch (e, s) {
        debugPrint('Erro ao inicializar DI: $e');
        debugPrintStack(stackTrace: s);
        rethrow;
      }

      // Captura erros Flutter e não-FLutter para registrar/mostrar no UI em vez de tela branca
      FlutterError.onError = (FlutterErrorDetails details) {
        // Imprime no console e encaminha para o zone
        FlutterError.presentError(details);
        Zone.current.handleUncaughtError(
          details.exception,
          details.stack ?? StackTrace.current,
        );
      };

      // Substitui o ErrorWidget para exibir a exceção diretamente na UI (útil para debugging web)
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Material(
          child: Center(
            child: Text(
              'Erro em tempo de execução:\n${details.exceptionAsString()}',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        );
      };

      runApp(const MyApp());
    },
    (error, stack) {
      // Loga erros não capturados no zone no console
      debugPrint('Unhandled zone error:');
      debugPrint('$error');
      debugPrintStack(stackTrace: stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardController>(
          create: (_) => DashboardController()..loadAll(),
        ),
        ChangeNotifierProvider<AuthController>(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance Dashboard',
        theme: ThemeData(
          primaryColor: Colors.blue[900],
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.figtreeTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[900],
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[400], // azul claro
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
        onGenerateRoute: (settings) {
          final builder = AppRoutes.routes[settings.name];
          if (builder != null) {
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  builder(context),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
              transitionDuration: const Duration(milliseconds: 400),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}
