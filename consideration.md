# Scaffoldzoid app

A new Flutter project.

## Step 1
- Story Boarding of the Project 
    a) There are users as follows :- i) buyer ii) seller
    b) Story of seller
        1) Seller can register by providing name , mobile number , email, password , confirm password and type of user.
        2) Seller can login by providing email credentials and password , confirm password.
        3) Seller can check there Dashboard/ Home Page where options provided such as :-
            a) Create Product : where seller can create a record of orange variant with its price, discount rate, MRP.
            b) Read Product : Here seller can check all created records.
            c) Update Product : Here seller can update any product from the list which they have created earlier.
            d) Delete Product : Here seller can delete the product which they have created earlier. 
        4) Seller can Navigate between Home and Account page through Bottom Navigation Bar
        5) Seller can view there profile image , description and logout option (to logout from the account)
        6) on the right corner a edit icon is provided for the seller where they would be navigated to Edit Profile page
        7) in the Edit Profile a description box is provided for the seller to fill-in
    c) Story of buyer
          1) buyer can register by providing name , mobile number , email, password , confirm password and type of user.
          2) buyer can login by providing email credentials and password , confirm password.
          3) buyer can check there Dashboard/ Home Page where they can select any seller to get it's rate chart
          4) buyer can click the seller list and they will be navigated to Seller's Page where the rated 
          5) buyer can Navigate between Home and Account page through Bottom Navigation Bar
          6) buyer can view there profile image , description and logout option (to logout from the account)
          7) on the right corner a edit icon is provided for the buyer where they would be navigated to Edit Profile page
  
-   Tech Stack Used :-
    a) Firebase
    b) FireStore Database
    c) Firebase Storage
    d) Flutter of App Development
    e) Architecture - MVVM
    d) state management tool - Provider
    e) Git for version control
    
-   Database Insights :-
    a) Collection(Users) => document(id) => fields(email,id,mobile,name,password,type)
    b) Collection(Produts) => document(product_id)=> fields(product_discount,product_id,product_mrp,product_name,product_price)
    c) Collection(desc) => document(user_id)=> fields(user_id,desc)
    d) Collection(images) => document(user_id)=> fields(user_id,image_url)


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
