import 'package:flutter/material.dart';
import 'package:organizagro/view/widgets/organizagro_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();

  static const name = '/about';
}

class _AboutScreenState extends State<AboutScreen> {
  Future<void> _linkLaunch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o app'),
      ),
      drawer: const OrganizagroDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Expanded(
              child: ListView(
                children: [
                  const ListTile(
                    title: Text(
                      'Organizagro é um aplicativo desenvolvido pelo estudante Luidson Lima Santos como projeto para a disciplina Atividade Extensionista II do curso de Análise e Desenvolvimento de Sistemas do Centro Universitário Uninter.',
                    ),
                  ),
                  const ListTile(
                      title: Text(
                    'O objetivo deste app é ser uma ferramenta intuitiva e funcional que auxilia pequenos agricultores a se planejarem, visando melhorar sua eficiência produtiva.',
                  )),
                  ListTile(
                    title: TextButton(
                      child: const Text('Linkedin'),
                      onPressed: () => _linkLaunch(Uri.parse(
                          'https://www.linkedin.com/in/luidson-lima-santos-844ba523b/')),
                    ),
                  ),
                  ListTile(
                    title: TextButton(
                      child: const Text('Repositório do projeto'),
                      onPressed: () => _linkLaunch(
                          Uri.parse('https://github.com/luidsonl/organizagro')),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
