# Event Booking System

## Overview

The Event Booking System is a web application designed to facilitate the creation, management, and booking of events. Users can browse available events, book tickets, and manage their bookings seamlessly. The application aims to provide an intuitive user experience while ensuring robust backend functionalities for event organizers.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Architecture](#architecture)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)

## Features

- User registration and authentication (Devise)
- Create, view, and manage events
- Browse available events
- Ticket booking
- Concurrency handling with caching

## Technologies Used

- **Backend**: Ruby on Rails
- **Frontend**: HTML, CSS, JavaScript
- **Database**: PostgreSQL
- **Authentication**: Devise for user authentication
- **Caching**: Rails caching for performance optimization

## Architecture

The application follows the MVC (Model-View-Controller) architecture pattern:

- **Models**: Handle the application's data and business logic (e.g., User, Event, Booking).
- **Views**: Define the presentation layer (e.g., ERB templates for event listings, booking forms).
- **Controllers**: Manage the flow of data between models and views, handling user requests and responses.
- **Services**: Manage the flow of booking creation with caching and database locking using services.

## Setup Instructions

To set up the Event Booking System locally, follow these steps:

1. **Setup Ruby and Rails**:
   - We are using Ruby `3.2.4` and Rails `7.0.4`.
   - Set up PostgreSQL.

2. **Clone the repository**:

   ```bash
   git clone https://github.com/subhanevolvers/event-booking.git
   cd event-booking

3. **Start Services**:

    ```bash
    bundle install
    rails db:setup
    rails s
