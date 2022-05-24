# API testing framework with Karate

The aim of this project is to serve as a start point for testers aiming to develop an automation framework to test their APIs and microservices from scratch.

---
## Notes
### Why [Karate](https://github.com/karatelabs/karate)?
- **Main features**:
  - It is open source with an active community behind.
  - Features a powerful assertion library.
  - Generates an intuitive html report after every run.
- **Main drawbacks**:
  - It doesn't provide Intellisense support for IDEs, so you have to be really careful to avoid spelling mistakes.
### Which application is being tested?
You can run [this](https://github.com/gothinkster/angular-realworld-example-app) awesome application in your local machine and play around with it to test its api requests. To set it up just follow these steps:
  - Clone the repository in your local machine.
  - Open a terminal in the root of the project.
  - Execute ``nmp install`` and wait for it to end installing dependencies.
  - Execute ``npm start``. Once is ready access [http://localhost:4200/](http://localhost:4200/) in your browser.
  - Then create an account (on your local application) and set those credential in the ``karate-config.js`` file.

Now let's test the tests:
- Clone this repository in your local machine and open it with your preferred IDE.
- You can run the tests of the feature files using the jUnit runner or simply ``mvn test`` from the root of the tests project.