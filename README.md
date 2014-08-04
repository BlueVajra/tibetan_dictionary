Tibetan Dictionary
==================

[![Build Status](https://travis-ci.org/BlueVajra/tibetan_dictionary.svg?branch=master)](https://travis-ci.org/BlueVajra/tibetan_dictionary)

##Crowdsourced Tibetan Dictionary

Enables Translators and students to make notes and comments about terminology

This was an idea I have been throwing around in my head for a while. I wanted a place where I could save my own comments and ideas about terminology that I heard from different teachers and mentors.
Often, these amazing insights are now lost in a pile of notebooks, handwritten and unreadable.

### Who is this for?
- students can keep translation notes
- teachers can create vocab lists to share with students
- academics and translators can store text references and share them with colleagues
- translators can "up-vote" other translators' comments and entries.
- any student of Tibetan language to store and share their ideas and the wisdom of others.
- publishers and authors can add book glossaries

##Dreams and Goals - current todo list

1. ~~search the Rangjung Yeshe Dictionary~~
1. ~~add entries to personal dictionary for searching~~
1. ~~comment on entries / group discussion~~
1. share private dictionaries with others
1. create pdf of personal glossaries
1. import csv glossaries
1. add book glossaries

## Links

- https://www.pivotaltracker.com/n/projects/1071684
- http://tibetan-dictionary-test.herokuapp.com/
- http://tibetan-dictionary.herokuapp.com/

- https://travis-ci.org/BlueVajra/tibetan_dictionary

## Set up local machine

1. fork and clone
2. `bundle`
3. `rake db:create db:migrate`
  1. there will be no dictionaries, but you can add your own in the db/dictionaries folder and change the seed file.
4. `rails s`

Please let me know if this doesn't work!