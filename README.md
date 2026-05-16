
# ♻️ Smart Recycling Waste System (SRWS) - Mobile App
The SRWS Mobile Application is a state-of-the-art Flutter solution designed to revolutionize waste management. By leveraging Artificial Intelligence and a modern microservice architecture, it allows users to identify waste types in real-time and learn proper disposal habits.
##  Core Architecture
To ensure maximum scalability and maintainability, this application adopts a Pragmatic Clean Architecture approach, heavily utilizing the Repository Pattern. We strictly followed the "Separation of Concerns" principle but deliberately avoided over-engineering (such as adding redundant Domain/UseCase layers) to maintain high performance and code readability, adhering to official Flutter best practices.
One of the most important technical aspects of this project is the Repository Pattern used in the Data Layer.

### Isolation of Concerns: The Repository layer isolates the data source (FastAPI AI Service) from the rest of the application.

### Robust & Flexible: Our code is organized, error-resistant, and highly flexible against technological changes.

### Plug-and-Play Capability: If we decide to change our AI provider or database infrastructure in the future, the UI and Business Logic code remain untouched. We only update the specific Repository.

## Key UX Features & Innovations
3-Second Laser Animation: To provide "Visual Feedback," a custom laser scanning animation is triggered, giving users a high-tech feel while the AI processes the image.

#### Continuous Demo Mode: Unlike traditional apps, the ScannerCubit is optimized for a continuous workflow. After a successful scan, the camera remains active so users can sort multiple items without interruption.

### Interactive Waste Guide: Detailed waste cards educate users on the environmental impact and correct bins for each material.

## 📂 Application Screens
### Splash Screen: Dynamic initial loading.

### Home Dashboard: Quick access to the scanner and history.

### Guide Screen: Comprehensive database of waste types and recycling tips.

### AI Scanner: Real-time camera feed with a high-tech scanning overlay.

## How to Run the Project
### Testing on Web Server
###To quickly test the UI on your local browser:
### flutter run -d web-server --web-port=8080

## Testing on Android Emulator
### Launch the emulator:
### flutter emulators --launch Pixel_6

## Run the application:
### flutter run -d emulator-5554
