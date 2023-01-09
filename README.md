# Burger Finder
<p align="center">
  <a href="https://github.com/feyzatopgul/Burger-Finder">
  </a>
  <p align="row">
    Burger Finder is a mobile iOS app developed with Swift. It is an app that users can find burger places in any location.
  </p>
<p align="center">
<img src= "https://media.giphy.com/media/QI9cAyHSC7NBQxswRY/giphy.gif" width="200"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp   
<img src= "https://media.giphy.com/media/1Rkfq6m9ZjDaJrAheI/giphy.gif" width="200"> <br /> 
<img src= "https://media.giphy.com/media/bsIECnXDrokxyhPbjE/giphy.gif" width="200"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  
<img src= "https://media.giphy.com/media/hMfq6vbWZMx1pEdsRK/giphy.gif" width="200"> <br /> 
<img src= "https://i.imgur.com/MKfQ3Nm.png" width="200"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
<img src= "https://i.imgur.com/P2NeH0F.png" width="200"> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
<img src= "https://i.imgur.com/1amvVPS.png" width="200">
</p>

## Functionalities
A user can
- See popular burger places around if location service is allowed. 
- Search burger places in any location based on the distance to that location
- Search any burger place in a given location
- Perform search in a list view or in a mapview
- Get place details as photos, ratings, price, address, hours, website and phone number
- Call a place 
- Open website of a place
- Get directions to a place
- Save and delete a place in favorites
- Search a place in favorites

## Requirements

- iOS 16.2
- Xcode 14.2 

## Technologies

- Swift
- UIKIT
- MapKit
- CoreLocation
- CoreData

## Architecture

**MVVM** is used as design pattern because it reduces the complexity in view contollers, seperates the business logic from views and it is more testable. Each view controller has its own view model. View controllers are only exposed to the relevant view models and view models provide data for the views.

There are five service classes that view models use. All these classes are designed using Singleton pattern. They have a shared instance and this instance is available from anywhere in the program. Dependency injection is performed to create loosely coupled objects. 

- **NetworkManager:** Handles network requests and decodes the returned JSON data into a model. It is a generic class that you can handle any network requests.

- **LocationManager:** Handles location authorization and authorization changes, provides current location and searched loation coordinates.

- **ImageLoader:** Downloads an image using an image url and returns the image data. In memory image caching is used with NSCache to prevent downloading the same image again and again to improve app performance.

- **CoreDataManager:** CoreData is used for persistency. This class is responsible for fetching, filtering, saving and deleting data.

- **NetworkReachability:** Provides network connection status.

### Model&APIs

<img src= "https://i.imgur.com/qEDkgRT.png" width="600">

### HomeView

HomeViewController displays 10 popular burger places around if the location service is enabled. If the location is not enabled, a warningView is displayed to ask users to enable locations. It also shows an alert when the device is not connected to the internet. There is a search button that performs navigation to SearchViewController.

<img src= "https://i.imgur.com/ykiC5F8.png" width="800">

### SearchView

Search bars are used to perform location and place search. If the location is enabled it displays near burger places by default. The results are displayed on a tableView or a mapView. Users can switch display mode using right bar button item. In mapView custom annotations are created. Users can navigate to DetailsViewController from a tableview cell or info button on the callout in annotations in the mapView. Maximum 50 results are displayed for each search.

<img src= "https://i.imgur.com/qDAjPCp.png" width="800">

### DetailsView

Photos of the selected place is shown in a collectionView. Maximum 20 photos are displayed. Users can navigate to PhotoViewController from a collectionView cell. Rating, price, address, hours, website and phone number information are displayed in a scrollView. Users can open website, call and get directions of the place. Users can add the place to favorites and delete the place from favorites using right bar button.

<img src= "https://i.imgur.com/4duDUbk.png" width="800">

### PhotoView

Expands the selected photo and displays it. Custom animation is performed for presenting this view controller.

<img src= "https://i.imgur.com/yUXYIiK.png" width="400">

### FavoritesView

Displays the favorite places in a collectionView. Search bar is used to make searches according to the name and the location of the places. Users can navigate to DetailsViewController from a a collectionView cell.

<img src= "https://i.imgur.com/4V2IpZl.png" width="400">

## Installation

1. Download and open ```Burger Finder.xcodeproj```.  
2. Navigate to ```ServiceManager/NetworkManager/NetworkConstants``` file and replace ```YOUR_KEY!``` with your ```API_KEY```
3. If you are using a simulator, please provide a location from ```Features > Location```
4. Build and run. 

## Future Development Goals

- LogIn/LogOut feature can be added
- Pagination can be performed to fetch more data
- Autocompletion can be added in SearchView 

## Meta

Feyza Topgul – [@FeyzaTopgul](https://twitter.com/FeyzaTopgul) – feyzatopgul@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

