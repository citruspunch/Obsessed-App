# Obsessed App

Welcome to the Obsessed App, an user-friendly mobile app built to offer great features and benefits for anyone interested in staying up-to-date with the latest trends. Developed with the Flutter framework and integrated with Supabase for real-time data handling, this app is designed to provide a seamless and engaging shopping experience. With a sleek and intuitive user interface, the Obsessed App offers a wide range of features, including a trending fashion carousel, detailed product insights, effortless shopping cart management, favorites functionality, and robust user account management.

## Key Features

- **Trending Fashion Carousel**: Displays the latest fashion trends dynamically on the home screen. Users can swipe through the carousel to explore new arrivals and popular items. 
- **Detailed Product Insights**: Provide comprehensive details about products, including descriptions, sizes, colors, and pricing. Users can view the product images and make informed decisions before purchasing.
- **Effortless Shopping Cart Management**: Simplify the checkout process with an intuitive shopping cart that allows for easy modifications and reviews. Users can add, remove, and update items in the cart with a few taps. 
- **Favorites Functionality**: Easily mark items as favorites for quick access to preferred outfits.
- **Search Functionality**: Users can search for specific products using the search bar, making it easier to find desired items.
- **Robust User Account Management**: Secure sign-up, login, profile editing, and purchase history review functionalities are available for enhanced user experience. Users can manage their account details and track their shopping history with ease. Profile editing includes updating your profile picture, name, last name, country, city and gender.
- **Intuitive Navigation**: Ensure easy navigation across the app with a user-friendly bottom navigation bar.
- **Real-time Updates**: Leverage Supabase's real-time database features to ensure that product listings and user favorites are always up-to-date.
- **Stock Availability**: Users can view the availability of products in real-time, if it's available users can select a quantity, if not a message: 'no stock available' displays, ensuring that they are informed about the stock status before making a purchase.
- **Product Reviews**: This feature enables users to access reviews and ratings from other customers, facilitating informed purchasing decisions. Reviews are dynamically retrieved from an API endpoint, ensuring up-to-date feedback on products.
- **Fetching Products from API**:  All product information, including specifications, descriptions, images, and pricing, along with customer reviews and ratings, are dynamically fetched from an API.
- **Fetching Countries and Cities from API**: The app fetches a list of countries and cities from an API, enabling users to select their country and city during profile creation editing or in the payment finalization screen. 

## Development Best Practices

### Flutter and Dart

- **Clean Architecture Implementation**: The app is structured according to Clean Architecture principles, ensuring a clear separation of concerns by organizing the code into distinct layers: Presentation, Domain, and infrastructure. This approach facilitates maintainability, scalability, and testability.
- **State Management**: State management is handled efficiently through the Provider package, ensuring scalability and maintainability.
- **Reusable Widgets**: Custom widgets have been developed for repeated use across the app, promoting UI consistency and code maintainability.

### Supabase Integration

- **Secure Authentication**: Integration with Supabase guarantees a secure and reliable authentication process.
- **Real-time Updates**: Leveraging Supabase's real-time database features, the app ensures that cart products and user favorites are always up-to-date.

### Mailgun Integration
- **Email Notifications**: The app integrates Mailgun to efficiently dispatches email notifications to users, providing them with detailed confirmation emails covering all aspects of their purchases.

### Code Quality and Maintenance

- **Secure Configuration**: Sensitive configuration details are securely stored in environment variables, adhering to best security practices.
- **Version Control**: The codebase is managed using Git, enabling version control and collaboration among developers.
- **Responsive Design**: The app is designed to be responsive and adaptive to various screen sizes, ensuring a consistent user experience across devices.

## Getting Started

To begin exploring the Obsessed App, follow these simple steps to dive into the experience:

1. **Download the App**: Click [here](https://drive.google.com/drive/folders/147oj2J3fwnoP8ulDRyOGYTQMIzkwxtMw?usp=sharing) to download the Obsessed App APK. 
2. **Install the App**: Open the downloaded APK file on your device and follow the prompts to install.
3. **Test the App**:
   - **Effortless Entry with a Test Account**: For an immediate dive into the App, employ the credentials of the test account:
     - **Email**: userobsessedapp@gmail.com
     - **Password**: user_password
   - **Create Your Account**: If you want to set up your own account, just choose the sign-up option and follow the simple steps.
4. **Explore**: Once logged in, you're all set to explore the various features and functionalities of the Obsessed App.

Enjoy your journey with the Obsessed App!