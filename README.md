# ElectroBill - The Bulgarian Electric Bill Calculator
### This is a calculator with UI focused on the Bulgarian language, that allows you to calculate your monthly electric bill, based on your Usage, Power Consumption, and local Price.


## Usage
### Example usage instructions
1. Clone and install the project (see the "Installation" instructions down below)
2. Open the app on your iOS device or simulator.
3. Navigate to the settings page on the simulator to customize preferences.
    *  General -> Language & Region -> Number Format -> Set to 4th option (1234 567.89)
4. Use the main screen to interact with the core features
- Input your details in the text fields:
  
![ScreenRecording2024-01-20at14 13 28-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/74423721-d6c0-4190-b587-5089cdc4aea9)

- Click "Калкулирай" to show you how much this appliance will cost in a day/week/month:
- Click "Запази" to save your data:

![ScreenRecording2024-01-20at14 27 17-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/eef30684-eb49-4616-8847-bb6dd7ec555c)

- After adding your data, you can navigate to the "Резултат" screen. There you can see a list of all the appliances the user added. On the top, there are 3 items: two buttons and one label.
The label calculates all of the appliances's monthly bills and adds them to the label. If the monthly sum is lower than 150 the label's text will be green, if it is lower than 200 it will be yellow, and higher than that it will be red.

![ScreenRecording2024-01-20at14 45 38-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/f162cbbd-4630-4066-945d-8f452e512aa7)

## Features
* The app uses Realm to store the user's database. If you close the app, the user's data will be persisted and will stay intact:

![ScreenRecording2024-01-20at13 42 32-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/22605d74-6cd0-4d64-9acd-1c11041914a4)

* When inputting your power consumption data, you can choose between kWh and Wh. Based on what you choose the calculations will be correct. Sometimes the appliance company does not provide the kWh power usage, but it gives the watts per hour. The formula for calculating the monthly bill is kWh * timePerHour * price:

![wat-kwh-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/b27c7d24-0a0c-43a1-bb1a-c2de51ba1938)

* If the user is inputting text fields, they can dismiss the keyboard by clicking anywhere on the screen:

![ScreenRecording2024-01-20at14 42 06-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/df1e25f5-9626-4c57-a9d3-2eaff418ccb9)

* When the user is in the "Резултат" screen, he can delete individual cells, by swiping right. When a user does that, the label that calculates the monthly bill sum automatically updates. If he chooses to click the "trash" icon in the upper left corner, it will delete all the cells at ones.

![Untitled-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/a5602373-7306-4ae3-833a-08bd21959e45)

![ScreenRecording2024-01-20at13 44 16-ezgif com-resize](https://github.com/John-Mark01/BG_ElectroBill/assets/147177515/9349148c-34b8-4baa-89c1-93b01cb009e6)

## Dependencies

In this project, I have used some cocoapods to add functionality to the app. Here is the list:
* RealmSwift
* SwipeCellKit
* IQKeyboardManagerSwift

## Installation
# Example installation steps
1. Clone the repository
   ```bash
   git clone https://github.com/your-username/your-ios-app.git


## Contact

If you want to contribute to this project or have any questions, you can contact me:
- Email: johnmark.iliev@gmail.com
- Facebook: https://www.facebook.com/john.iliev.92/

