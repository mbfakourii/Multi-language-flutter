import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_language/settings.dart';
import 'generated/l10n.dart';
import 'language_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(builder: (context, lang) {
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: lang,
          home: const MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLanguage();
    return Scaffold(
      appBar: AppBar(title: const Text("Multi language")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Settings()));
              },
              child: const Text("Setting")),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).pageHomeListTitle,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(""),
                  Text(
                    S.of(context).pageHomeSamplePlaceholder('John'),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    S.of(context).pageHomeSamplePlaceholdersOrdered('John', 'Doe'),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    S.of(context).pageHomeSamplePlural(2),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    S.of(context).pageHomeSampleTotalAmount(2500.0),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    S.of(context).pageHomeSampleCurrentDateTime(DateTime.now(), DateTime.now()),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "currentLanguage\n    $currentLanguage",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    "currentLanguageIsSystemLocal: $currentLanguageIsSystemLocal",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
