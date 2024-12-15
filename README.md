# Feel Better App

## Final Project Report - California State University, Fullerton  
**Course**: CPSC 411-06: Computer Science Mobile Dev Programming  
**Developers**:  
- **Andreia Shin** (CWID: 884976077)  
- **Sadia Khan** (CWID: 885907980)  
**Semester**: Fall 2024  
**Date**: December 13, 2024

---

## Project Goals
The **Feel Better App** is designed to:
- **Promote Mental Health**: Encourage habits of gratitude, self-reflection, and mindfulness.  
- **Enhance Accessibility**: Provide accessible mental health tools for those without access to therapy.  
- **User-Friendly Experience**: Offer a simple and intuitive interface.  
- **Empower Self-Care**: Allow users to track moods, practice meditation, and maintain a gratitude journal.  
- **Positive Habits**: Support routines around gratitude, mindfulness, and emotional tracking.  
- **Improve Development Skills**: Strengthen expertise in **SwiftUI** and **Core Data**.  

---

## Functionalities

### Mood Tracking  
- Log daily emotions using emojis and add comments.  
- View past moods, dates, and comments.  
- Visualize trends with graphs to identify triggers or patterns.  

### Guided Meditations  
- 3-minute guided audio meditations with background sounds (e.g., nature or white noise).  
- Provide text and audio tips for enhancing meditation practices.  

### Journaling  
- Log experiences via text, video, or pictures.  
- Display random past entries to encourage reflection.  
- Add new entries or search specific past entries through an intuitive interface.  

---

## Architecture and Design

### Frontend (SwiftUI Views)
**SwiftUI Components**:  
- **ContentView.swift**: Main app entry point.  
- **BrowseJournalEntriesScreen.swift**: View for browsing journal entries.  
- **CircleProgressView.swift**: Displays progress indicators.  
- **MoodChartView.swift**: Shows mood trends.  
- **MeditationView.swift**: Hosts guided meditation content.  
- **MoodDisplay.swift**: Displays mood details.  
- **VideoView.swift**: Handles video playback.  

**Design Philosophy**:  
- Modular and reusable views for scalability.  
- Declarative design for clarity and maintainability.  

---

### Data Layer (Core Data)
**Core Data Components**:  
- **Feel_Better_App.xcdatamodeld**: Manages mood and journal data.  
- **CoreDataManager.swift**: Handles CRUD operations.  
- **Persistence.swift**: Integrates Core Data stack.  

**Model Classes**:  
- **MoodEntry+CoreDataClass.swift**: Defines the MoodEntry entity.  
- **MoodEntry+CoreDataProperties.swift**: Includes properties like date and mood value.  

---

### Key Considerations:  
- Clear separation of concerns (Views, Data Models, and Logic).  
- Modular for future expansion.  
- Optimized for performance.  

---

### Future Enhancements
- Add user authentication for personalized experiences.  
- Integrate **CloudKit** for cloud synchronization.  
- Enhance mood analytics and provide recommendations.  
- Implement push notifications.  
- Add advanced photo and video functionalities.  

---

## Documentation of the Project

### GitHub Location of Code
- **Repository URL**  
   ```bash
    https://github.com/deiaashin2/FeelBetterApp

---

### Deployment Instructions

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/deiaashin2/FeelBetterApp
2.	**Install Prerequisites**
	- Ensure that Xcode is installed on your Mac and updated to the latest version.
	- Verify you have CocoaPods or any other dependency manager specified in the project (if applicable).
3.	**Set Up Dependencies**
    - Navigate to the project directory and run pod install (if CocoaPods is used).
    - Check for any README or setup files for additional instructions.

---

### Run Instructions
1. **Open the Project**
    - Open the .xcworkspace file (if CocoaPods is used) or the .xcodeproj file in Xcode.
2. **Select a Device or Simulator**
    - Choose a simulator or connected device in Xcode.
3. **Build and Run**
    - Use the Run button or press **Cmd + R** to build and run the app.
