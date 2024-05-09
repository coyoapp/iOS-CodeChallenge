# Hola! 👋 👾 🎲

This project is a challenge that consist of improving the codebase of a project.

## Prelude: The Challenge

I started by having a look to the whole project, and doing some easy-boyscouting.

After this initial look, I understood the project structure, divided into 3 main "verticals" represented by the modules: Posts, Users and Profile. All of them were using the same global functions from the `APIHandler`, that did not follow neither OOP either SOLID, and introduced instability given some _force unwraps_ over there, unused parameters, and the abscence of both network & error handling.

## Part I: Introducing Clean Architecture

It is the architecture I am most comfortable working with.

According to some other refactoring patterns I have learnt during my time, I prepared "the land" in which I would start moving things and adding new ones. This is, the folder named `Clean`, which is divided into three main sub-folders, each of them representing one of the Clean layers: `Presentation`, `Domain` and `Data`.

I usually combine Clean Architecture with MVVM (for the `Presentation` layer) establishing the relationships as follows:

* [`Presentation`] The `View` holds a reference to the `ViewModel`, and listens for changes on it.
* [`Presentation` -> `Domain`] The `ViewModel` has references to the different `UseCases` of `Domain`.
* [`Domain`] These `UseCases` performs the business logic according to the data received from `Data`.
* [`Data` -> `Domain`] The `Repositories` are the ones serving the data to `Domain`, asking the right data to the right `DataSource`.

## Part II: Posts

So, right after having introduced the new `ApiClient` in `Data`, I fully migrated the `Posts` vertical. It presented some nice problems like concurrency issues, caused by the creation of multiple `Tasks` that were mutating one non thread-safe attribute.

## Part III: Profile

It was built taking into account another architecture: `VIPER`. However, the implementation was inaccurate.

The `Router` was not really _routing_; the `Entitiy` was supposed to be the one getting and managing the data; the `Interactor`, the one handling the business logic; the `View` had a `ViewModel` that was only holding the real data for the view, and a `ViewHandler`; and the `Presenter` was in charge of doing everything.

Something interesting I noticed here was the relationship between the View and the Presenter. The `weak` was in the wrong direction, so after cleaning a bit the `App` class, I had to revert this in order to avoid the app crashing (due to a fancy _fatalError_ indicating the view did not exist yet).

In anycase and again, I did the full migration to Clean, creating the appropiate domain objects, repositories, data sources, DTOs, converters, etc.

## Part IV: Users

A massive and impressive `ViewController`. Even though it would have been easier to migrate this to SwiftUI and get rid of the `UIViewControllerRepresentable`, I decided to keep it and work on it.

So, I implemented a classic `Presenter`, with a reference back to the view (`weak`). For the _Dependency Injection_ I like to use something called: `Configurator`. It fully configures the view by creating an instance of the `Presenter`, and its subsequent dependencies. Lately, this instance is assigned to the `ViewController`, which is passed through as a parameter.

As an interesting fact, the `CollectionView` had a performance issue when dequeuing the cell. Since `UICollectionViewCell` does not have default elements like `UITableViewCell` has, it made sense to manually create a label and add it to the cell. However, at the moment of reusing the cell, the app adds one new label to cell once and again, on top of the previous added one. Apart from the bad performance, one could see how the different labels were overlapped.

Creating a custom cell from the scratch solves this issue.

## Part V: The Final Touches

The best for the end. I have prepared some unit tests for demonstrating how easy is to build them using by creating and ijecting mocks. Programming via protocols is the key to guarantee a good level of decoupling, and be able to inject whatever instance as soon as it conforms to the protocol.

For UITests, I usually make use of the `PageObject` pattern ([link here](https://martinfowler.com/bliki/PageObject.html)) because it allows to write really readable tests without digging into the technical details. It keeps the level of abstraction high and focuses on the User journey (the "Happy Path").

And finally, during the challenge I focused a lot in architecture, concurrency and parallelism, error handling, data management, UITests, ... which in the end are the things I really love to do! But I left the UI a bit alone... So I took some time to re-design a bit `Posts` and `Profile`, adding some new iOS17 features, like:

* The `.scrollTransition` modifier, for animating items when entering and going out of a list
* The `.gradient` modifier for `Color`, that directly generates the gradient

Without anything else to add, all that remains is to say... thank you for your time reading here, and the code!

👾
