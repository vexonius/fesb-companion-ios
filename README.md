# FESB Companion iOS

FESB Companion iOS is a iOS mobile application designed for FESB (Faculty of Electrical Engineering, Mechanical Engineering and Naval Architecture) students.

## Overview

This iOS application serves as a companion app for FESB students, providing easy access to essential faculty resources and information.

## Features

- View your semester timetable and events
- Access attendance and Studomat resources
- Check your balance on Iksica and overview all of your receipts. Get the daily menu at the faculty restaurants on the campus.
- Keep track with your assignments and todos
- Get notified when your next class starts

## Requirements

- iOS 18.0
- Xcode 16.0
- Swift 5.9

## Installation

1. Clone the repository
```bash
git clone https://github.com/vexonius/fesb-companion-ios.git
```
2. Install tuist
```bash
brew install tuist
```
4. Fetch dependencies and create Xcode project file
```bash
tuist fetch
tuist generate
```
6. Open project in Xcode and run it. (You may need to change signing config in project settings in FESBCompanion target)
7. Success

### Tech Stack:
Tuist
Swift
SwiftUI

### Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (git checkout -b feature/AmazingFeature)
3. Commit your changes (git commit -m 'Add some AmazingFeature')
4. Push to the branch (git push origin feature/AmazingFeature)
5. Open a Pull Request

### License
MIT License
