import 'package:flashly/flashly.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlashlyExampleApp());
}

class FlashlyExampleApp extends StatelessWidget {
  const FlashlyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashly Example',
      navigatorKey: Flashly.navigatorKey,
      scaffoldMessengerKey: Flashly.scaffoldMessengerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC)),
        useMaterial3: true,
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashly Example')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Alerts',
            children: [
              _DemoButton(
                label: 'Success alert',
                onPressed: () => showAlert(
                  'Operação concluída',
                  description: 'Seus dados foram salvos com sucesso.',
                  positiveTitle: 'OK',
                  state: AlertState.success,
                  context: context,
                ),
              ),
              _DemoButton(
                label: 'Error alert',
                onPressed: () => showAlert(
                  'Algo deu errado',
                  description: 'Não foi possível completar a operação.',
                  negativeTitle: 'Cancelar',
                  positiveTitle: 'Tentar novamente',
                  state: AlertState.error,
                  isDestructive: true,
                  context: context,
                ),
              ),
              _DemoButton(
                label: 'Info alert',
                onPressed: () => showAlert(
                  'Informação',
                  description: 'Esta ação requer sua atenção.',
                  state: AlertState.info,
                  context: context,
                ),
              ),
              _DemoButton(
                label: 'Warning alert',
                onPressed: () => showAlert(
                  'Atenção',
                  description: 'Verifique os dados antes de continuar.',
                  state: AlertState.warning,
                  positiveTitle: 'Entendi',
                  context: context,
                ),
              ),
              _DemoButton(
                label: 'Loader alert',
                onPressed: () {
                  showLoaderAlert(
                    placeholder: 'Carregando',
                    closeLoaderAfterSecs: 5,
                    context: context,
                  );
                },
              ),
            ],
          ),
          _Section(
            title: 'Toasts',
            children: [
              _DemoButton(
                label: 'Success toast',
                onPressed: () => showToast('Copiado para a área de transferência'),
              ),
              _DemoButton(
                label: 'Error toast',
                onPressed: () => showToast(
                  'Falha ao enviar',
                  state: ToastState.error,
                ),
              ),
              _DemoButton(
                label: 'Info toast',
                onPressed: () => showToast(
                  'Sincronização em andamento',
                  state: ToastState.info,
                ),
              ),
            ],
          ),
          _Section(
            title: 'Widgets',
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: SizedBox(width: 32, height: 32, child: _LoaderPreview())),
              ),
              Row(
                children: [
                  Expanded(
                    child: AlertActionButton(
                      text: 'Cancelar',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AlertActionButton(
                      text: 'Confirmar',
                      isPositive: true,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoaderPreview extends StatelessWidget {
  const _LoaderPreview();

  @override
  Widget build(BuildContext context) {
    return loader(color: Theme.of(context).colorScheme.primary);
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 8),
      ],
    );
  }
}

class _DemoButton extends StatelessWidget {
  const _DemoButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
