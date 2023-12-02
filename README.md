# Spendy App
Simplify receipt management by auto-converting total amounts to your preferred currency.

# How it works? 
Very simple! 

To add your receipt you need to:
1. Choose your main currency to which you want to convert your receipts. You can change it anytime.
2. Add your receipt: add a name, a category, receipt currency, total amount, date of the purchase (it automatically shows current date) and items that you purchased.

There's more:
- On the second tab you will see all your added receipts and its converted amounts. Exchange rates are in real-time. So you will get a fresh rates data when you add a receipt.
- If you want to remember what you bought, tap on list item and will fall to the detail view of you receipt.
- If you added a receipt by mistake, you can easily delete it by swiping to the left (or use "Edit" button).

# Dependencies 
To run the application you need to:
- Sign in at the https://app.freecurrencyapi.com/. Choose a live currency rates and get a Default Key (live).
- In Xcode project create a plist named "FCAPI-Info.plist".
- Add a new key/value pair. Name for the key: API_KEY. For the value data type choose String and add you key.   

# How requirements were achieved? 

Project files grouped into folders and subfolders. 

1. Folder Networking -> CurrencyService.swift

App receives its exchange rates data from the FreecurrencyAPI. Rate limit of allowed concurrent requests: 10 per min.
Networking code is in a CurrencyService class which conforms to the ObservableObject.

2. Folder Model -> ReceiptStore.swift

ReceiptStore class has 2 @Published values: addingReceipt and receipts to which 5 views subscribes to.
The receipts array is saved locally on the user's device.

3. Folder Views -> subfolder TabViews -> ReceiptTabView

ReceiptTabView is a second tab view. It shows a list of added receipts. Data is shown in the List view. If the receipts array is empty the screen asks user to go to the Home tab and add receipts. Also in case if the amount isn't converted and shows 0.00, at the toolbar there's an icon with a popover message for the user to try again later. 

From this view you can go to the detailed view of the chosen receipt. 

4. Folder Views -> subfolder ReceiptViews -> ReceiptView.swift

ReceiptView is a detailed view that shows all the data for the particular receipt.

5. Folder Views -> LaunchScreen.swift

Animated launch screen. The opacity of the icon and text changes with animation.

6. Folder SpendyAppTests -> SpendyAppTests and Folder SpendyAppUITests -> SpendyAppUITests

Here you can find unit and UI tests. Code coverage is 67%.

7. Assets

A custom app icon, custom category icons and backgrounds for the launch screen (for landscape and portrait modes) are stored there.

# SwiftLint
The project utilizes SwiftLint with Kodeco’s configuration file. 5 warnings were disabled due to general cases: force unwrapping, force unwrapping optionals and 1 function had 6 parameters instead of 5(it was defined by the model data — struct Receipt).
