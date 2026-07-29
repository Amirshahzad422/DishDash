# 🍔 DishDash — Branded Restaurant Food Ordering App

A production-quality, responsive food ordering application frontend built with **Flutter** and **Provider**. Designed as a complete, multi-screen, reusable component-driven solution that seamlessly runs across **Mobile (Android & iOS)**, **Tablet**, and **Desktop Web** from a single codebase.

---

## 📌 Project Overview

**DishDash** is a modern startup case study application designed to solve restaurant ordering inefficiencies. It provides customers with a visual, intuitive interface to browse menus, customize dishes with add-ons, manage a shopping cart, place orders, track live order status in real time, and save favorite dishes.

### 🌟 Key Highlights
- **Single Codebase, Multi-Platform**: Flawlessly scales across Mobile, Tablet, and Desktop Web breakpoints.
- **100% Client-Side Mock Layer**: Powered by a decoupled local dataset (`lib/data/`), eliminating external backend dependencies for rapid demoing and testing.
- **Reactive State Management**: Built using `provider` for global state persistence across Cart, Favourites, Active Filters, and Orders.
- **Redeployable Architecture**: Designed as a white-label component system. Any restaurant can rebrand DishDash by modifying `app_colors.dart` and `mock_food_data.dart`.

---

## ✨ Features & Subsystems

### 1. 🚀 Splash & Navigation
- **Animated Splash Screen**: Smooth logo scale, fade-in animations, tagline, and progress indicator with automatic route transition.
- **Responsive Layout Engine**:
  - **Mobile**: Floating bottom navigation bar (`CustomBottomNavBar`) with badge indicators.
  - **Tablet**: Slide-out navigation drawer (`Drawer`).
  - **Desktop**: Full-width header navigation bar (`CustomAppBar`) with inline links and quick action badges.

### 2. 🏠 Home & Landing Page
- **Hero Banner Carousel**: Interactive banner showcasing top promotions and daily deals.
- **Category Filter Bar**: Quick category filtering with visual icons.
- **Chef's Specials**: Highlighted grid of top-rated items with 1-line truncated descriptions.
- **Why Choose Us**: Feature highlights (Master Chefs, Fast Delivery, Fresh Ingredients).
- **Testimonials Carousel**: Real customer feedback cards with rating stars.
- **Footer**: Comprehensive navigation links, contact details, social links, and newsletter subscription box.

### 3. 🍕 Menu & Discovery
- **Grid & List Layout Toggle**: Switch between responsive 2-column food grid cards and horizontal list cards.
- **Pagination & Counter**: Smooth page navigation controls and active item counts.
- **Advanced Search & Multi-Filter Panel**:
  - Keyword search across name & description.
  - Category selection (Pizzas, Burgers, Drinks, Salads, Desserts).
  - Price range slider & minimum rating filter.
  - Dietary filters (**VEG**, **SPICY** badges).
  - Multi-option sorting (*Newest*, *Price: Low to High*, *Price: High to Low*, *Popular*).
- **Empty States & Skeleton Loaders**: Custom designed empty state graphics when no items match active filters.

### 4. 📖 Food Details & Customization
- **Interactive Image Gallery**: High-resolution image viewer with full-screen zoom modal.
- **Item Metrics**: Prep time, calorie count, rating, and dietary tags.
- **Add-ons & Options**: Selectable extras (Extra Cheese, Spicy Sauce, Gluten-Free Base, Double Patty) with dynamic price calculation.
- **Customer Reviews**: Rating breakdown and customer feedback list.
- **Similar Items Carousel**: Recommended food items based on category.

### 5. 🛒 Cart & Checkout
- **Cart Management**: Real-time quantity increment/decrement, item removal, and subtotal calculation.
- **Price Breakdown**: Detailed breakdown including Subtotal, Delivery Fee, Estimated Tax, and Discount.
- **Promo Code Box**: Interactive voucher redemption box.
- **Checkout Flow**:
  - Order type selector (*Delivery*, *Pickup*, *Dine-in*).
  - Address input & delivery note field.
  - Payment method selection (*Credit Card*, *Cash on Delivery*, *Apple/Google Pay*).
  - Confirmation screen upon placing an order.

### 6. 🛵 Live Order Tracking & Favourites
- **Live Order Status Simulation**: `OrdersProvider` includes a 15-second background simulation timer (`Timer.periodic`) that automatically steps active orders through live statuses:
  $$\text{Placed} \longrightarrow \text{Preparing} \longrightarrow \text{Ready} \longrightarrow \text{On the way} \longrightarrow \text{Delivered}$$
- **Visual Status Timeline**: Interactive horizontal stepper highlighting completed delivery milestones.
- **Order History & Reorder**: Past order log with a 1-click **REORDER** button to reload items into the cart.
- **Favourites Manager**: Persistent heart button toggle across food cards and detail pages, with a dedicated **Favourites Tab** in `OrderScreen`.

### 7. 📄 Supporting Pages
- **Profile Screen**: User info, saved delivery addresses, payment methods, and settings.
- **About Us Screen**: Restaurant story, core values, metrics, and master chef profiles.
- **Contact & FAQ Screen**: Interactive inquiry form, office location details, social links, and searchable FAQ accordions.
- **Custom 404 Screen**: Friendly route fallback page for invalid URLs.

---

## 🏗️ Architecture & Folder Structure

Built strictly according to the **Verxeon Technologies Case Study** standard layout:

```
lib/
├── assets/             # Static media, illustrations, and images
├── components/         # Reusable atomic UI building blocks
│   ├── app_bar/        # Responsive header AppBar
│   ├── bottom_nav/     # Mobile Bottom Navigation Bar
│   ├── buttons/        # Standard button variants
│   ├── category_card/  # Category item chips & cards
│   ├── custom_banner/  # Hero banner carousel
│   ├── filters/        # Advanced Filter Panel
│   ├── food_card/      # Reusable Food Card (Grid & List views)
│   ├── footer/         # Global Footer component
│   ├── loader/         # Skeleton loaders
│   ├── modal/          # Reusable dialogs & image zoom modal
│   ├── search_bar/     # Search input widget
│   └── testimonials/   # Review cards & testimonials
├── data/               # Single source of truth mock dataset
│   ├── mock_categories.dart
│   ├── mock_food_data.dart
│   └── mock_reviews.dart
├── hooks/              # Custom mixins & hooks
├── layouts/            # MainLayout responsive wrapper
├── models/             # Data models (FoodItem, Order, Category, Review)
├── providers/          # Global state management (Cart, Favourites, Filter, Orders)
├── routes/             # AppRouter (Named routing & argument passing)
├── screens/            # Route-level screens (Home, Menu, FoodDetails, Cart, Checkout, Orders, Profile, About, Contact, NotFound, Splash)
├── styles/             # Global AppColors and AppTheme definitions
├── utils/              # Currency/Date formatters and Responsive helpers
└── main.dart           # Application entry point
```

---

## ⚙️ Getting Started

### Prerequisites
- **Flutter SDK**: `>=3.0.0`
- **Dart SDK**: `>=3.0.0`

### Installation & Execution

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/verxeon-ai/DishDash.git
   cd dishdash
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run Static Code Analysis**:
   ```bash
   flutter analyze
   ```

4. **Launch the Application**:
   - **Chrome (Desktop Web)**:
     ```bash
     flutter run -d chrome
     ```
   - **Android / iOS Emulator**:
     ```bash
     flutter run
     ```

---

## 🎨 Customization & Rebranding Guide

To rebrand DishDash for another restaurant or client:

1. **Colors & Theme**: Modify `lib/styles/app_colors.dart` to change primary, secondary, and accent brand colors.
2. **Menu & Categories**: Update `lib/data/mock_food_data.dart` and `lib/data/mock_categories.dart` to swap food items, prices, images, and descriptions.
3. **App Title & Branding**: Change the app name and logo icon in `lib/components/app_bar/custom_app_bar.dart` and `lib/screens/splash/splash_screen.dart`.

---

## 📝 Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Typography**: [Google Fonts](https://pub.dev/packages/google_fonts) (Poppins)
- **Icons**: Material Icons

---

