# Sample Flutter App: Clean Code & Structure

This project is a testament to what a well-structured Flutter application looks like. It's not about the features; it's about the clarity of the structure and the quality of the code. With foundational services from Firebase (Authentication, Crashlytics, Analytics, Notification) and a concise feature set, this project showcases clean code principles in action. Its primary purpose is to provide a jumping-off point for larger projects, giving developers a structural template to expand upon.

The core project requires Firebase integration for operation. However, in order to protect sensitive information, Firebase details like `google_service` and `firebase_options` have been omitted from this repository. This app is versatile, with support for iOS, Android, and Web platforms. With the use of Provider for state management, onboarding logic, application-wide custom themes, and unit tests for the main features, it stands as a robust starting point for any Flutter enthusiast.

## Key Highlights:

- **Architecture**: The app leverages a modular architecture, ensuring separation of concerns and scalability.
- **State Management**: Using the Provider package, the app maintains a reactive state, ensuring UI updates efficiently.
- **Navigation**: Streamlined navigation ensures that users have a smooth experience.
- **UI and Widget Logics**: With a focus on user experience, every widget is meticulously crafted and backed by logic to ensure responsiveness and adaptability.

## Project Structure:

1. **Providers**
    - **User Provider**: Handles communication with Firestore for user-related operations. 
    - **Auth Provider**: Manages user authentication states and methods.
2. **Models**
    - **User**: Data structure for user-related information.
3. **Service**: Contains service-related logic and API integrations.
4. **UI**
    - **Common Widgets**: Reusable widgets to maintain consistency throughout the app.
    - **Screens**: All main views/screens of the application.
    - **Styles**: Defines the theme, text styles, and other UI-related constants.
5. **Utils**: Houses text constants, utility functions, and other shared resources.
6. **Main**: The starting point of the application.

## Firebase Integration:

To set up Firebase and the associated services, follow the steps below:

1. **Basic Setup**: Use the Firebase CLI and FlutterFire for integrating Firebase apps (Web, iOS, Android). 
    - [Firebase Setup Guide for Flutter](https://firebase.google.com/docs/flutter/setup?platform=ios)
2. **Add Analytics**:
    - [Firebase Analytics Guide for Flutter](https://firebase.google.com/docs/analytics/get-started?platform=flutter)
3. **Integrate Crashlytics**:
    - [Firebase Crashlytics Guide for Flutter](https://firebase.google.com/docs/crashlytics/customize-crash-reports?platform=flutter)
4. **Set Up Firebase Messaging**:
    - [Firebase Messaging Guide for Flutter](https://pub.dev/packages/firebase_messaging)
    - *Note*: For iOS, remember to add the necessary capabilities in Xcode and create an APN certificate.
5. **Authentication Setup**: Add authentication methods in Firebase (Apple and Google). Ensure you have the `service_json` for Google, add capabilities for iOS, and include the `client_id` for the web in the `index.html` file.

With these integrations, the app is not just about the features but is built on a solid foundation. Future updates will focus on expanding the User Provider throughout the app, building complex features, and adding a navigation system with persistent states.
