# weather_app

Flutter Clean Architecture & TDD | Weather App Project
Using Ancel Pop Architecture

Notes: 
* because we need to implement weather repository in data layer, we make the weather repository class as an abstract class, because domain layer should be completly inependent on other layers, so weather repo in domain layer independent in repo data layer, so we need to use INVERSION in SOLID Principles.

* depending on SINGLE RESPONSIIPILTY in SOLID Principle each usecase must be independent of the others
