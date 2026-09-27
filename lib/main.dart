import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TravelApp());
}

class Destination {
  final String name;
  final IconData icon;

  const Destination({
    required this.name,
    required this.icon,
  });
}

class TravelDeal {
  final String title;
  final double price;
  final String description;
  final bool isPremium;

  const TravelDeal({
    required this.title,
    required this.price,
    required this.description,
    required this.isPremium,
  });
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.lato(fontSize: 16),
        ),
      ),
      home: const TravelDashboard(),
    );
  }
}

class TravelDashboard extends StatelessWidget {
  const TravelDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Destination> destinations = const [
      Destination(name: 'Home', icon: Icons.home),
      Destination(name: 'Explore', icon: Icons.explore),
      Destination(name: 'Bookings', icon: Icons.book),
      Destination(name: 'Profile', icon: Icons.person),
    ];

    final width = MediaQuery.sizeOf(context).width;

    if (width < 600) {
      return MobileLayout(destinations: destinations);
    }

    return DesktopLayout(destinations: destinations);
  }
}

class MobileLayout extends StatelessWidget {
  final List<Destination> destinations;

  const MobileLayout({
    super.key,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> navItems = [];

    for (final destination in destinations) {
      navItems.add(
        Expanded(
          child: ListTile(
            leading: Icon(destination.icon),
            onTap: () {},
          ),
        ),
      );
    }

    return Scaffold(
      body: const DealDashboard(),
      bottomNavigationBar: BottomAppBar(
        child: Row(children: navItems),
      ),
    );
  }
}

class DesktopLayout extends StatelessWidget {
  final List<Destination> destinations;

  const DesktopLayout({
    super.key,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> navItems = [];

    for (final destination in destinations) {
      navItems.add(
        ListTile(
          leading: Icon(destination.icon),
          title: Text(destination.name),
          onTap: () {},
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Column(children: navItems),
          ),
          const Expanded(
            child: DealDashboard(),
          ),
        ],
      ),
    );
  }
}

class DealDashboard extends StatelessWidget {
  const DealDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TravelDeal> deals = const [
      TravelDeal(
        title: 'Beach Getaway',
        price: 399.99,
        description: 'A beach trip.',
        isPremium: false,
      ),
      TravelDeal(
        title: 'Luxury City Stay',
        price: 899.99,
        description: 'A city trip.',
        isPremium: true,
      ),
      TravelDeal(
        title: 'Mountain Trip',
        price: 499.99,
        description: 'A mountain trip.',
        isPremium: false,
      ),
    ];

    List<Widget> dealCards = [];

    for (final deal in deals) {
      if (deal.isPremium) {
        dealCards.add(
          Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepOrange,
                brightness: Brightness.light,
              ),
            ),
            child: DealCard(deal: deal),
          ),
        );
      } else {
        dealCards.add(DealCard(deal: deal));
      }
    }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 400) {
            return GridView.count(
              crossAxisCount: 2,
              children: dealCards,
            );
          }

          return ListView(children: dealCards);
        },
      ),
    );
  }
}

class DealCard extends StatelessWidget {
  final TravelDeal deal;

  const DealCard({
    super.key,
    required this.deal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        title: Text(
          deal.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          '\$${deal.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}