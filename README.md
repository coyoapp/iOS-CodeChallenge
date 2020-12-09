# COYO - Code Challenge
### Position: iOS Developer

We're glad that you're considering a position here at COYO. Thank you for having time to invest in this code challenge.

### Deliverable

We need you to submit a demo project to be evaluated by our engineers. You can choose between two formats:

1. [The COYO demo project.](#coyo-demo-Project)
2. [A project you've already done.](#previously-written-project)

The app architecture, project, code organization, file structure, and comments will be evaluated.

Send your code challenge in a `.zip` file by e-mail to your recruiter.

## COYO Demo Project

We need you to create an app that allows our users from a social network to see posts and comments.

The app consists of two screens: a list of posts and the post details.

We won't provide any UI specification, this is totally up to you. Free the designer soul inside you. ;)

### Posts Screen

A post has a title. When a post is tapped, the user should be redirected to the detail screen.

### Post Detail

For the post detail, we expect to see its author, description, number of comments, and the comments.

### API

Here is the [API docs](http://jsonplaceholder.typicode.com), you should use the following endpoints:

 - `/posts`
 - `/comments`
 - `/users`

We expect you to use the `GET` method only.

### Requirements

- Use Swift 5.1 or above
- It should compile and run.
- Provide a `COMMENTS.md` file mentioned in [Notes](#notes).

## Previously written project

You can send us a project you've done before. This project must follow the requirements below:

 - Swift 5.1 or above.
 - Have at least three distinct network calls to a REST API.
 - Parse a JSON response and present the information to the user.
 - Have some sort of persistence mechanism.
 - Have a point of synchronization (e.g. making two concurrent requests and waiting for both of them to finish).
 - Compile and run.
 - Provide a `COMMENTS.md` file mentioned in [Notes](#notes). Also a description of what the project does, in order to give us some context.

## Notes

* This assessment must be delivered within 2 days.
* We like code that is simple, but [simple is different from easy](https://www.infoq.com/presentations/Simple-Made-Easy).
* Keep in mind the [SOLID principles](https://en.wikipedia.org/wiki/SOLID_(object-oriented_design)) when doing the project.
* Testing is very important for us. Even if you don't write a single test (for instance, because of time constraints), your app should be easy to test.
* Error scenarios should be taken into consideration and it should be easy to add them, even if you don't explicitly handle them.
* Although UI and UX are important, we are more concerned in this demo with your thought process and with how you architect your application. Your demo should take into consideration features that might be added in the future.
* You can use any third-party libraries you wish, but be prepared to justify why you did so (don't forget that we want to evaluate **YOUR** skills). If so, please use a dependency manager.
* Keep in mind you're developing an app to be used over cellular data. Would be nice if you provide a way to save the user's data plan.
* **Be consistent in your code**. We advise using something like [GitHub's Swift style guide](https://github.com/github/swift-style-guide) while doing the demo. It's absolutely fine to use any other style, as long as you are consistent.
* You must provide a `COMMENTS.md` file at the root of your repository, explaining:
    * Main architecture decisions you've made and a quick explanation of why.
    * List of third-party libraries and why you chose each one.
    * What could be improved if you had more time.
    * Mention anything that was asked but not delivered and why, and any additional comments.
