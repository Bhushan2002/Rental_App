import 'package:rental_application/models/PropertyModel.dart';

final List<Property> propertData = [
  // 1
  Property(
    id: 'prop001',
    type: PropertyType.Apartment,
    title: "Shree Ganesh Heights, 2 BHK in Wakad",
    description:
        "A beautiful and spacious 2 BHK apartment available for rent in the prime location of Wakad. Close to Hinjewadi IT Park and well-connected to the city.",
    price: 22000,
    location: "Wakad, Pune",
    bedrooms: 2,
    bathrooms: 2,
    area: 950,
    images: [
      "https://images.unsplash.com/photo-1737898394554-f8045ccb337e?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ],
    bhk: 2,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_101',
    amenities: ['parking', 'lift', 'security', 'gym'],
  ),

  // 2
  Property(
    id: 'prop002',
    type: PropertyType.Apartment,
    title: "Royal Orchid Suites, 3 BHK Furnished Flat",
    description:
        "Luxurious fully furnished 3 BHK apartment in the heart of Koregaon Park. Features modern interiors and premium fittings, ready to move in.",
    price: 45000,
    location: "Koregaon Park, Pune",
    bedrooms: 3,
    images: [
      "https://images.unsplash.com/photo-1737898378300-0e64a5f6c52d?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ],
    bathrooms: 3,
    area: 1500,
    bhk: 3,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_102',
    amenities: ['wifi', 'pool', 'parking', 'gym', 'clubhouse'],
  ),

  // 3
  Property(
    id: 'prop003',
    type: PropertyType.Apartment,
    title: "Shanti Niwas, 1 BHK for Rent",
    description:
        "Cozy and well-ventilated 1 BHK flat in Baner, perfect for students or working professionals. Close to Balewadi High Street.",
    price: 16000,
    location: "Baner, Pune",
    bedrooms: 1,
    bathrooms: 1,
    area: 600,
    images: [
      'https://images.unsplash.com/photo-1643949915197-2984de8bbd92?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    bhk: 1,
    isAvailable: false,
    createdAt: DateTime.now(),
    ownerId: 'own_103',
    amenities: ['parking', 'lift', 'cctv'],
  ),

  // 4
  Property(
    id: 'prop004',
    type: PropertyType.Apartment,
    title: "Sai Sadan, 2 BHK near Airport",
    description:
        "Conveniently located 2 BHK apartment in Viman Nagar. Excellent connectivity to Pune Airport, Phoenix Marketcity, and Kharadi IT hubs.",
    price: 25000,
    location: "Viman Nagar, Pune",
    images: [
      'https://images.unsplash.com/photo-1684161610011-a56b0271b942?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    bedrooms: 2,
    bathrooms: 2,
    area: 1050,
    bhk: 2,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_104',
    amenities: ['power backup', 'security', 'parking', 'children\'s play area'],
  ),

  // 5
  Property(
    id: 'prop005',
    type: PropertyType.Apartment,
    title: "Saraswati Bhuvan, 3 BHK in Kothrud",
    description:
        "Spacious 3 BHK apartment in the peaceful and established locality of Kothrud. Ideal for families, with schools and markets nearby.",
    price: 28000,
    location: "Kothrud, Pune",
    images: [
      'https://images.unsplash.com/photo-1722890552192-23472a17e33b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    bedrooms: 3,
    bathrooms: 2,
    area: 1300,
    bhk: 3,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_105',
    amenities: ['parking', 'lift', 'gas pipeline'],
  ),

  // 6
  Property(
    id: 'prop006',
    type: PropertyType.Apartment,
    title: "Silver Oak Residency, 2 BHK Pimple Saudagar",
    description:
        "A modern 2 BHK flat in a well-maintained society in Pimple Saudagar. Comes with all essential amenities and a vibrant community.",
    price: 20000,
    location: "Pimple Saudagar, Pune",
    bedrooms: 2,
    bathrooms: 2,
    area: 900,
    bhk: 2,
    images: [
      'https://images.unsplash.com/photo-1655270527682-5c0811aa972a?q=80&w=690&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_106',
    amenities: ['pool', 'gym', 'parking', 'clubhouse', 'security'],
  ),

  // 7
  Property(
    id: 'prop007',
    type: PropertyType.Apartment,
    title: "EON Homes, 2 BHK near IT Park",
    description:
        "Premium 2 BHK apartment in Kharadi, just a stone's throw away from EON IT Park and World Trade Center. Perfect for IT professionals.",
    price: 27000,
    location: "Kharadi, Pune",
    bedrooms: 2,
    images: [
      'https://images.unsplash.com/photo-1627141440602-e9c1e5fd2fbf?q=80&w=1169&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    bathrooms: 2,
    area: 1100,
    bhk: 2,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_107',
    amenities: ['wifi', 'parking', 'lift', 'power backup', 'pool'],
  ),

  // 8
  Property(
    id: 'prop008',
    type: PropertyType.House,
    title: "Jasmine Row House in Magarpatta City",
    description:
        "Independent 3 BHK Row House within the secure and green environment of Magarpatta City. Offers privacy and access to world-class amenities.",
    price: 55000,
    location: "Magarpatta City, Hadapsar, Pune",
    bedrooms: 3,
    bathrooms: 3,
    images: [
      'https://images.unsplash.com/photo-1638284457192-27d3d0ec51aa?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    area: 1800,
    bhk: 3,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_108',
    amenities: ['parking', 'security', 'clubhouse', 'garden'],
  ),

  // 9
  Property(
    id: 'prop009',
    type: PropertyType.Apartment,
    title: "Westside View, Premium 2 BHK in Aundh",
    description:
        "A well-designed, semi-furnished 2 BHK in the upscale area of Aundh. Features a modular kitchen and wardrobes.",
    price: 30000,
    images: [
      'https://images.unsplash.com/photo-1611094016919-36b65678f3d6?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    location: "Aundh, Pune",
    bedrooms: 2,
    bathrooms: 2,
    area: 1200,
    bhk: 2,
    isAvailable: false,
    createdAt: DateTime.now(),
    ownerId: 'own_109',
    amenities: ['parking', 'lift', 'security', 'cctv', 'gym'],
  ),

  // 10
  Property(
    id: 'prop010',
    type: PropertyType.Apartment,
    title: "Blue Ridge Township, 1 BHK Compact",
    description:
        "Compact and affordable 1 BHK in the acclaimed Blue Ridge township, Hinjewadi Phase 1. Perfect for bachelors working in the IT park.",
    images: [
      'https://images.unsplash.com/photo-1635108197387-c4cade0a80b7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ],
    price: 14000,
    location: "Hinjewadi Phase 1, Pune",
    bedrooms: 1,
    bathrooms: 1,
    area: 550,
    bhk: 1,
    isAvailable: true,
    createdAt: DateTime.now(),
    ownerId: 'own_110',
    amenities: ['parking', 'lift', 'pool', 'gym', 'security'],
  ),
];
