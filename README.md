# Food API Flutter App

A Flutter food-ordering application with category browsing, meal search, cart management, Razorpay checkout, and local order history.

## Overview

This project uses TheMealDB API for meal data and Provider for state management. Users can:

- Browse meal categories and featured meals
- Search meals by name
- Add meals to cart
- Checkout using Razorpay
- View order history saved locally

## Tech Stack

- Flutter (Dart)
- Provider (state management)
- Dio (HTTP client)
- SQFlite (local persistence)
- Razorpay Flutter SDK (payments)

## Project Structure

```text
foodapi/
├── lib/
│   ├── main.dart
│   ├── Api/
│   │   ├── api_response.dart
│   │   ├── api_service.dart
│   │   └── endpoints.dart
│   ├── models/
│   │   ├── cart_model.dart
│   │   ├── category_model.dart
│   │   ├── food_model.dart
│   │   ├── meal_model.dart
│   │   ├── order_item_model.dart
│   │   └── order_model.dart
│   ├── provider/
│   │   ├── cart_provider.dart
│   │   ├── food_provider.dart
│   │   └── order_database.dart
│   ├── services/
│   │   ├── cart_database.dart
│   │   └── order_database.dart
│   ├── viewmodels/
│   │   ├── home_viewmodel.dart
│   │   └── search_viewmodel.dart
│   └── views/
│       ├── navigation/
│       │   └── app_shell.dart
│       ├── home/
│       │   └── home.dart
│       ├── search/
│       │   └── search_page.dart
│       ├── details/
│       │   └── food_details_page.dart
│       ├── category/
│       │   └── catergory_meals_page.dart
│       ├── cart/
│       │   └── cart_page.dart
│       ├── payment/
│       │   └── payment_page.dart
│       ├── order/
│       │   └── order_history_page.dart
│       └── widgets/
│           ├── bottom_nav_bar.dart
│           ├── cart_items.dart
│           ├── food.dart
│           └── food_cart.dart
├── android/
├── ios/
├── web/
├── linux/
├── macos/
├── windows/
└── pubspec.yaml
```

## App Architecture

- API Layer
	Handles remote requests and standardized response handling.
	- api_service.dart
	- endpoints.dart
	- api_response.dart

- State Layer
	Business logic and state updates using Provider and ViewModels.
	- home_viewmodel.dart
	- search_viewmodel.dart
	- cart_provider.dart
	- order provider logic

- Persistence Layer
	Local database for cart and orders.
	- services/cart_database.dart
	- services/order_database.dart

- UI Layer
	Screen-level views and reusable widgets.
	- views/*
	- views/widgets/*

## Features

- Home screen with categories and featured meals
- Meal details screen with add-to-cart action
- Search with API-backed meal list
- Cart with quantity updates, subtotal, tax, and total
- Payment handoff via Razorpay
- Order history persisted locally

## Setup

1. Install Flutter SDK.
2. Clone the repository.
3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Configuration Notes

- Razorpay test key is set in the payment page.
- API base endpoint is configured in endpoints.dart.
- Local database tables are auto-created on first launch.

## Common Issues

- Network timeout on emulator:
	Check emulator internet connectivity.

- SQLite create-table error:
	Ensure SQL uses CREATE TABLE (not misspelled) and reinstall app if schema is stale.

- Profile/network image load failure:
	This usually means DNS/network issue in emulator.

## Future Improvements

- Replace hardcoded strings with localization
- Add unit tests for providers/viewmodels
- Move constants/colors into theme files
- Add profile page and account state

## License

This project is for learning and development purposes.
