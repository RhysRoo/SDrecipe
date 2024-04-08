Recipe Management System README

Introduction

This repository contains the source code for a Recipe Management System. The system aims to provide users with a platform to manage recipes, generate personalized recipe recommendations, and interact with other users. It includes features such as user authentication, account creation, profile management, dynamic recipe generation, food warning notifications, about-us page, recipe rating, adding own recipes, and an FAQ page.

Requirements

The system is designed to meet both functional and non-functional requirements specified below:

Functional Requirements:
- User Authentication Control
    - Ability to trigger authentication
    - Ability to terminate authentication
    - Ability to resume authentication after a halt

User Account Creation Control
    - Ability to initiate account creation
    - Ability of temporary suspension of an ongoing account creation process
    - Ability of the system to resume the process after suspension

User Profile
    - Ability to create and manage a profile with personal information and preferences

Dynamic Recipe Generation
    - Ability to dynamically generate a list of top 10 recipes based on user food restrictions and selected ingredients
    - Food Warning Notifications
    - Ability to provide notifications about expired food items that have been selected

About-Us Page
    - Ability to display relevant information about the platform and mission
    - Ability to include features such as team member profiles or contact forms

Recipe Rating
    - Ability to rate recipes on a scale or provide viable feedback

Add Own Recipes
    - Ability to submit their own recipes through a user-friendly form

FAQ Page
    - Ability to organize common user queries and concerns  
    - Ability to search and quickly find answers to specific questions
    - Ability to add an FAQ
    - Ability to allow administrators to easily add, edit, or remove FAQ entries

Non-Functional Requirements:
    - Compatibility: The system must be compatible with IOS devices.
    - Performance: The system must respond within a maximum response time, and various processes should handle simultaneous loads without significant degradation in performance.
    - Security: The system must adhere to industrial-standard protocols for authentication, encryption, and data protection.
    - Scalability: The system should scale horizontally to accommodate an increasing number of users and interactions.
    - Availability: The system must ensure a minimum of 99% uptime.
    - Reliability: Features should load quickly and accurately.

    - Usability: The system should comply with accessibility standards, have an intuitive UI, and score highly in usability testing.

    - Compliance:
        - The system must comply with relevant data protection regulations, such as GDPR and HIPAA.

    - Quality Assurance:
        - Rigorous testing procedures, including security testing, must be conducted to ensure reliability and integrity.

Unit Tests for Speicification:
    - The extent to which the specification has been met in a 2 month development deadline.
    - /recipe_app/test/
