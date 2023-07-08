# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Service.create(name: 'Civil')
Service.create(name: 'Criminal')
Service.create(name: 'Family')
Service.create(name: 'Banking')

Service.first.categories.create(name: 'Stay Proceedings')
Service.first.categories.create(name: 'Recovery Suit')
Service.first.categories.create(name: 'Defamation Suit')
Service.first.categories.create(name: 'Specific performance')
Service.first.categories.create(name: 'Partition suit')
Service.first.categories.create(name: 'Declaration of legal heirs')
Service.first.categories.create(name: 'Declaration of rights')
Service.first.categories.create(name: 'Suit for Rendition of Accounts')
Service.first.categories.create(name: 'Suit for Cancellation of documents')

Service.second.categories.create(name: 'Bail matter (Pre-Arrest / Post arrest / Anticipatory / Protective)')
Service.second.categories.create(name: 'Registration of FIR')
Service.second.categories.create(name: 'Change of Investigation')
Service.second.categories.create(name: 'Petition U/S 22 A and B')
Service.second.categories.create(name: 'Trial')
Service.second.categories.create(name: 'Appeal in High Court & Supreme Court')
Service.second.categories.create(name: 'Harassment')

Service.third.categories.create(name: 'Court marriage')
Service.third.categories.create(name: 'Khula / Divorce / Separation')
Service.third.categories.create(name: 'Suit For Maintenance / Dower / Dowry')
Service.third.categories.create(name: 'Child Custody / Schedule of meeting of Minor (Children)')

Service.first.categories.create(name: 'Suit of Recovery')
Service.first.categories.create(name: 'Stay against bank')
Service.first.categories.create(name: 'Suit / Stay against illegal charges')
Service.first.categories.create(name: 'Stay against Bank for vehicle / property Auction')
