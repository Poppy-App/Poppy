
# Poppy

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Poppy allows college students to skip the hassles associated with selling and buying old items such as clothes, furniture, etc. This platform organizes all the items that are for sale and makes it easy for a consumer to find a multitude of options for what they are searching for. Sellers and buyers can chat through Poppy directly and negotiate a sale. 


### App Evaluation
- **Category:** E-commerce
- **Mobile:** It is more convenient to take pictures on a phone and it is more natural to communicate
- **Story:** We are a team of 4 college students who noticed Facebook Marketplace and similar services are often disorganized and have cases of fraud. Additonally, those services aren't tailored directly to students!
- **Market:** College Students
- **Habit:** Students will use this app every time they need to sell their old items or if they are on the market to buy an inexpensive used item. 
- **Scope:** This app will be feasible to do within our allotted time frame because its features are not uniquely complex. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] Login screen with user authentication
- [X] Create account screen with their school email and specify university name
- [X] Logout Functionality
- [X] Render all the availible products on the screen (partially implimented
- [ ] Take pictures of a product and upload them to the platform along with description
- [ ] Payment interface to allow users to pay others for their product
- [ ] Filter by price and categories
- [X] View more information about listing
- [ ] Settings screen where user can change name and description about themselves

**Optional Nice-to-have Stories**

- [ ] Chat between buyers and sellers
- [ ] Users can add profile picture
- [ ] Map to show product location

### 2. Screen Archetypes

* Login/Sign-in Screen
   * Login screen with user authentication
   * Sign up with their school email and specify university name
* All Listings
   * Render all the availible products on the screen
   * Filter by price and categories
* Add listing screen
    * Take pictures of a product and upload them to the platform along with description
* More information
    * View more information about listing
    * Payment interface to allow users to pay others for their product
* Settings Screen
    * Settings screen where user can change name and description about themselves

### 3. Navigation



**Flow Navigation** (Screen to Screen)

* Login/Sign-in Screen [default start screen when you open app for first time]
* Screen which shows listings [arrive at this screen directly from login/signup]
* Screen that shows addional info [arrive at this screen after clicking on a listing]
* Payment screen [arrive at this screen by cliicking the buy now button on on the additonal info screen]
* Screen to post [arrive at this screen after clicking on the + button on the main screen with all the listings]
* Settings screen [arrive at this screen by clicking on settings button on the main screen with all the listings]

## Wireframes

<img src="https://i.imgur.com/6haHwqp.png" alt="drawing" width="200"/>
<img src="https://i.imgur.com/kLBu9cD.png" alt="drawing" width="200"/>
<img src="https://i.imgur.com/uho6nYk.png" alt="drawing" width="200"/>
<img src="https://i.imgur.com/Qe63GDU.png" alt="drawing" width="200"/>
<img src="https://i.imgur.com/fjLo16D.png" alt="drawing" width="200"/>









## Schema 
### Models
#### Listing
| Property    | Type              | Description               |
| ----------- | ----------------- | ------------------------- |
| Listing ID  | long              | unique id for listing     |
| User        | Pointer to User   | listing seller            |
| Description | Text              | information about listing |
| Price       | Integer           | listing price             |
| Condition   | Text              | Condition of item         |
| Age         | Integer           | Age of Item               |

#### User
| Property     | Type   | Description           |
| ------------ | ------ | --------------------- |
| Name         | String | Seller name           |
| College      | String | Seller's College      |
| ItemsSold    | int    | # of items sold       |
| College Year | String | 1st, 2nd, 3rd etc.    |
| Bio          | String | information on seller |
| Payment Info |        | Apple pay value       |
| Email        | String | School Email          |
| Password     | String | Login Password        |



### Networking
- List of network requests by screen:
    1. Login Screen - Authentication from Firebase

    ```
    Firebase.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
      guard let strongSelf = self else { return }
      // ...
    }
    ```
    2. Create Account Screen - Authentication from Firebase

    ```
    Firebase.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
      // ...
    }
    ```

    3. Feed Screen - Request postings from Firebase

    ```
    let postsRef = Firestore.firestore().collection("listing")
    ```


    4. More information - Firebase API to get information, Apple Pay API to pay, Apple Maps to get location

    ```
    \\firebase
    let infoRef = Firestore.firestore().collection("users")
    ```
    ```
    \\apple maps
    mapkit.init({
        authorizationCallback: function(done) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/services/jwt");
            xhr.addEventListener("load", function() {
                done(this.responseText);
            });
            xhr.send();
        }
    });
    var map = new mapkit.Map("map", {
        isRotationEnabled: false,
        isZoomEnabled: false,
        showsZoomControl: false
    });
  ```
  ```
  \\apple pay
  let ticket = PKPaymentSummaryItem(label: "Festival Entry", amount: NSDecimalNumber(string: "9.99"), type: .final)
  let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "1.00"), type: .final)
  let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "10.99"), type: .final)
  paymentSummaryItems = [ticket, tax, total]
  let paymentRequest = PKPaymentRequest()
  paymentRequest.paymentSummaryItems = paymentSummaryItems
  paymentRequest.merchantIdentifier = Configuration.Merchant.identifier
  paymentRequest.merchantCapabilities = .capability3DS
  paymentRequest.countryCode = "US"
  paymentRequest.currencyCode = "USD"
  paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
  paymentRequest.shippingType = .delivery
  paymentRequest.shippingMethods = shippingMethodCalculator()
  paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
  #if !os(watchOS)
  paymentRequest.supportsCouponCode = true
  #endif`
  paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
  paymentController?.delegate = self
  paymentController?.present(completion: { (presented: Bool) in
      if presented {
          debugPrint("Presented payment controller")
      } else {
          debugPrint("Failed to present payment controller")
          self.completionHandler(false)
      }
  })
    
  ```
  ### Sprint 1 Progress GIF
  <img src='Poppy_Sprint1.gif' title='Video Walkthrough' width=250 alt='Video Walkthrough' />
  
  ### Sprint 2 Progress GIF
  <img src='Poppy_Sprint2.gif' title='Video Walkthrough' width=250 alt='Video Walkthrough' />



