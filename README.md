## Introduction

Ruby on Rails 7.1 project, designed to be a simple e-commerce.

To use this project, you initially connect the server with rails, but first, you need to use the following commands: rails db:drop, db:create and db:migrate.

Focus on the back-end, authentication is done in Devise, with an integer in roles, in this case the default: 0 is the User, and 1 is Admin.

## Main project settings

- [✓] - A nav-bar with all the actions that an e-commerce has (or almost all), including: links_to with create Product, remove cart, see the current cart, go to the home screen, etc.
- [✓] - Products in floating-box on the home screen (root_path)
- [✓] - Use Bootstrap 5, some icons, and use CSS to customize the front a little so it doesn't look like a pigsty, lol.
- [✓] - Make sure that only those who are going to make a cart, and go to checkout_confirmation, will only be LOGED users, if not, they will be required to register/log in with the DEVISE system.
- [✓] - In-app protections to prevent SQL injections, using ActiveRecord.
- [✓] - Associations configured to avoid future problems
- [✓] - Project writing to be as compressed as possible at the end of the project, for maintenance/scaling purposes using Docker
- [✓] - User Order History
- [✓] - Implement management of Products, carts and orders created by users.
- [✓] - Use Role 1 (Administrator) created in rails g devise User, as a way of administering the entire site.
- [✓] - Addition of comments to the project, where only another user other than the member can comment.
- [ ] - Notification bootstrap icon to show user's current/or past notifications with expiration up to 30d.
- [ ] - 

## Project dependencies

- Ruby - 3.2.2
- Rails - 7.1.1

- gem 'devise', 4.9
- gem 'faker'

## Future Additions

- [✓] - Add Cookies for more protection
- [✓] - Add Cryptograph SSL for more protection
- [✓] - Contingency and recovery plan, for unpredictable attack events using lib/tasks
- [ ] - Implementer addon (search 1 email and render all logs in index.html.erb)
- [ ] - Scale using Docker
- [ ] - 
- [ ] - 
