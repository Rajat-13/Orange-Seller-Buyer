# Scaffoldzoid app

A new Flutter project.

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
    d) Flutter for App Development
    e) Architecture - MVVM
    d) state management tool - Provider
    e) Git for version control
    
-   Database Insights :-
    a) Collection(users) => document(id) => fields(email,id,mobile,name,password,type)
    b) Collection(products) => document(product_id)=> fields(product_discount,product_id,product_mrp,product_name,product_price)
    c) Collection(desc) => document(user_id)=> fields(user_id,desc)
    d) Collection(images) => document(user_id)=> fields(user_id,image_url)

-   Data Flow :-

    1) The Request is generated from View.
    2) The request now through ViewModel Class hits the Repository.
    3) The repository routes the request to networkApiService Class.
    4) The networkApiService is responsible to send the data to the server and to receive the response from it.

-   Test Case :-
    1) Login Screen Integration Testing added.
    
-   Future Development :-
    1) More optimization of Code
    2) providing new functionality like Cart and Checkout System
    3) Enhancing the Look and feel of the App
    4) More Test Cases to add
    
