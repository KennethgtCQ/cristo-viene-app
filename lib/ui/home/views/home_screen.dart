
import 'package:flutter/material.dart';
import '../../../core/widgets/brand_mark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.isAdminPreview});

  final bool isAdminPreview;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final destinations = <({IconData icon, String label})>[
      (icon: Icons.home_outlined, label: 'Inicio'),
      (icon: Icons.article_outlined, label: 'Boletín'),
      (icon: Icons.event_outlined, label: 'Eventos'),
      (icon: Icons.groups_outlined, label: 'Ministerios'),
      (icon: Icons.person_outline, label: 'Perfil'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const BrandMark(compact: true),
        actions: [
          if (widget.isAdminPreview)
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.admin_panel_settings_outlined),
              label: const Text('Administración'),
            ),
          IconButton(
            onPressed: () {},
            tooltip: 'Notificaciones',
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          if (wide)
            NavigationRail(
              selectedIndex: _selected,
              onDestinationSelected: (value) {
                setState(() => _selected = value);
              },
              labelType: NavigationRailLabelType.all,
              destinations: destinations
                  .map(
                    (destination) => NavigationRailDestination(
                      icon: Icon(destination.icon),
                      label: Text(destination.label),
                    ),
                  )
                  .toList(),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 36 : 18,
                vertical: 22,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, qué alegría tenerte aquí',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Crezcamos juntos en comunidad y en fe.',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _heroCard(context),
                      const SizedBox(height: 28),
                      Text(
                        'Accesos rápidos',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 14),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final count =
                              constraints.maxWidth > 800 ? 4 : 2;

                          final items = [
                            (Icons.menu_book_outlined, 'Leer la Biblia'),
                            (
                              Icons.favorite_border_rounded,
                              'Peticiones de oración',
                            ),
                            (
                              Icons.volunteer_activism_outlined,
                              'Ofrendas',
                            ),
                            (Icons.groups_2_outlined, 'Ministerios'),
                          ];

                          return GridView.builder(
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: count,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1.8,
                            ),
                            itemBuilder: (context, index) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      items[index].$1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      size: 28,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      items[index].$2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'Próximo evento',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 14),
                      Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1511632765486-a01980e01a18?auto=format&fit=crop&w=160&q=80',
                              width: 76,
                              height: 76,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.event),
                            ),
                          ),
                          title: const Text('Reunión de comunidad'),
                          subtitle: const Text('Domingo · 10:00 a. m.'),
                          trailing:
                              const Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (widget.isAdminPreview) _adminPanel(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _selected,
              onDestinationSelected: (value) {
                setState(() => _selected = value);
              },
              destinations: destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: Icon(destination.icon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Widget _heroCard(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1507692049790-de58290a4334?auto=format&fit=crop&w=1600&q=85',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xD9000000),
              Color(0x10000000),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'UNA FE QUE NOS UNE',
              style: TextStyle(
                color: accent,
                letterSpacing: 2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hay un lugar para ti.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Conectados por la fe, creciendo en amor.',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Administración',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _AdminAction(
              icon: Icons.people_alt_outlined,
              label: 'Usuarios',
            ),
            _AdminAction(
              icon: Icons.groups_outlined,
              label: 'Ministerios',
            ),
            _AdminAction(
              icon: Icons.fact_check_outlined,
              label: 'Revisión de boletín',
            ),
            _AdminAction(
              icon: Icons.event_note_outlined,
              label: 'Eventos',
            ),
            _AdminAction(
              icon: Icons.volunteer_activism_outlined,
              label: 'Ofrendas',
            ),
            _AdminAction(
              icon: Icons.history_outlined,
              label: 'Auditoría',
            ),
          ],
        ),
      ],
    );
  }
}

class _AdminAction extends StatelessWidget {
  const _AdminAction({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(
            label,
            style: const TextStyle(fontSize: 13),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
