# Drinks Recipe App
## By Group 7

A recipe app that allows users to customize the recipes of three different types of drinks: Coffee, Milk Tea, and Smoothie. Users will have to sign up for an account to use the app. After signing in successfully, users can proceed to the DIY screen and choose different ingredients for their drinks. After users finish editing their ingredients, they can save the recipe or reset it to default. If users choose to save their recipes, they can view them on the History Screen. The recipes are listed in descending order, with the most recently created at the top and the earliest at the bottom. Users are not limited to saving one recipe. They can create any number of recipes they like and delete those they don't like. If users want to exit the app, they can log out on the Account Screen. If users quit the app without logging out, they will stay logged in on the app until they log out.

## Visuals  
[Click here to view on youtube](https://youtu.be/RLIhgW-FvH0)  
**Sign Up Page and Login Page**   
<img src = "img/signup.gif" width=300>
<img src = "img/login.gif" width=300>      

**DIY Page(three drink options) and History Page**  
<img src = "img/customization.gif" width=300>
<img src = "img/history.gif" width=300>   

**Account Page**  
<img src = "img/account.gif" width=300>
 
## Packages:
`cupertino_icons`^1.0.2: provides a set of ios style icons and buttons.   
`flutter_native_splash`^2.1.3+1: provides a splash screen that has the app logo as an intro.  
`fluttericon`^2.0.0: provides a set of icons.  
`get`^4.6.1: provides snackbars for in-app notifications.  
`dotted_line`^3.1.0: provides dotted_line dividers to separate contents in recipe options.    
`firebase_auth`^3.3.14: allows user to create an account in the app with Firebase Authentication.    
`cloud_firestore`^3.1.12: allows user to save, retrieve and delete their data(recipes) in a cloud-hosted, NoSQL database.   
`provider`^6.0.2: allows the app to check whether or not the user is authenticated.  If yes, proceed to home page, otherwise go to login page.   
`shared_preferences`^2.0.13: allows the app to store data locally which users can stay logged in when they quit the app, no need to login again.
 
## Progress  
- [x] User Authentication via Firebase   
- [x] User can save customized recipes in Firstore Database   
- [x] User can login to see a history list of recipes
- [x] User can remove recipes one at a time or all at once
- [x] User can stay logged in when the app is terminated, and logout at anytime they want
- [ ] User can edit their recipe in history page