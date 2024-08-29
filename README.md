# Spendy App
Simplify receipt management by auto-converting total amounts to your preferred currency.

# How it works 

Super simple!

1. Choose Your Main Currency: 
Pick the currency to which you want to convert your receipts. Change it anytime.

3. Add Your Receipt: 
Name, category, receipt currency, total amount, purchase date (auto-set to current date), and items.

More Features:

- On the second tab, see all your receipts and converted amounts in real-time.
- Fresh rates when you add a receipt.
- Tap a list item to view details of what you bought.
- Swipe left or use "Edit" to delete a receipt added by mistake.

# Dependencies 
To run the app:

1. Sign in at https://app.freecurrencyapi.com/, choose live currency rates, and get a Default Key (live).
2. In Xcode, create a plist named "FCAPI-Info.plist".
3. Add a key/value pair: Key - API_KEY, Value - your key (String). 

# How requirements were achieved? 

Project files grouped into folders and subfolders to follow MVVM model. 

1. Folder Networking -> CurrencyService.swift:

App receives its exchange rates data from the FreecurrencyAPI. Rate limit of allowed concurrent requests: 10 per min.
Networking code is in a CurrencyService class which conforms to the ObservableObject.

2. Folder Model -> ReceiptStore.swift:

ReceiptStore class has 2 @Published values: addingReceipt and receipts to which 5 views subscribes to.
The receipts array is saved locally on the user's device.

3. Folder Views -> subfolder TabViews -> ReceiptTabView:

Second tab view displaying a list of added receipts. If empty, prompts user to go to Home tab and add receipts. Also, handles cases where the amount isn't converted, showing 0.00, with a popover message to try again later.

From this view you can go to the detailed view of the chosen receipt. 

4. Folder Views -> subfolder ReceiptViews -> ReceiptView.swift:

ReceiptView is a detailed view that shows all the data for the particular receipt.

5. Folder Views -> LaunchScreen.swift:

Animated launch screen. The opacity of the icon and text changes with animation.

6. Folder SpendyAppTests -> SpendyAppTests and Folder SpendyAppUITests -> SpendyAppUITests:

Here you can find unit and UI tests. Code coverage is 67%.

7. Assets:

A custom app icon, custom category icons and backgrounds for the launch screen (for landscape and portrait modes) are stored there.

# SwiftLint
Project uses SwiftLint with Kodeco’s configuration file. Disabled 5 warnings for force unwrapping and 1 function with 6 parameters (due to model data — struct Receipt).
