# MVVM
An implementation of the MVVM + Clean architecture, for fun. (Swift)

**This project is under active development
and is expected to change significantly before its first stable release.**

## Motivation
Having an example project with common cases, for reference, like snippets, that allows the team to standardize the code and allow juniors to use it as a reference on how to do something in particular, like implement a collectionView or put a shadow in a cell.

When we want to standardize something, we implement it in this project and in this way we have an example of how it is implemented for the entire team. It also allows us to do implementation experiments.

### Requirements
 - MVVM
 - Testability
 - Code Organization
 - Code Reusability
### Cons
 - Potentialy for boileplate code
 - Overkill for simple views and logic
 
## Patterns
This project uses different patterns for its implementation, the idea, keep the two implementations as similar as possible bringing the implementation of iOS as close as possible to the Android team that uses the same patterns mentioned here. 

In this way it allows us at the time of task estimation allows us to give similar orders of magnitude for the same US.

### Coordinator 
Its responsibility is to show a new view, in this way we free the viewModel from managing the views and we also centralize them all by scenes.

### Boxing
Its responsibility is to bind the view Model properties to view, I like this technique, it is simple, clean and effective.

### MVVM
Presentation Pattern, the classic.

### Dependency injection.
To simplify testing we implement dependency injection.

### Services Locator
This pattern, right now, I have it in review, since first it is an anti-pattern and second when I have implemented it I did not like it, also as I implemented it badly it gave me memory leaks, for that reason I eliminated it and it is currently under review to see how we can improve it.
if you have suggestion it will be welcome

## APIs
For this project I have used public APIs.

##### The UK Police Open Data API
The API provides a rich data source for information, including:
- Neighbourhood team members
- Upcoming events
- Street-level crime and outcome data
- Nearest police stations
https://data.police.uk/docs/

##### The Punk API 
The Punk API takes Brewdog's DIY Dog and turns it into a searchable, filterable API that's completely free and open source.
https://punkapi.com

## Current implementation of the project:
### Home Scence:
A collectionView that retrieves data from a local json
### Forces Scene:
A tableView that retrieves data from a service. 
### Beers Scene:
A collectionView that retrieves data from a service.
### References:
The code of this project has been copied or created from other open source projects, manuals and tutorials. 
https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios
https://github.com/kudoleh/iOS-Clean-Architecture-MVVM
https://quickbirdstudios.com/blog/swift-dependency-injection-service-locators/

Oscar ([@okardona](https://twitter.com/okardona))



