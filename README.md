# Connections

This is an app aimed at creating connections between consultants in ThoughtWorks.

[![Build Status](https://snap-ci.com/thoughtworks/connections/branch/master/build_image)](https://snap-ci.com/thoughtworks/connections/branch/master)

## The How

Mostly, we are building an application that mines data from other internal apps within ThoughtWorks in order to provide useful information to the recipients. 
We currently have two 'apps' for this data and are planning to take advantage of external APIs to add additional data (see the future work section below). 

The first app is an email based notifier. The goal here is that with little to no interaction, the consultant is feed information that is useful to them in periodic updates. This information includes what other consultants they should be talking to, updates from those consultants, useful links or places to look for more information, etc. Right now this is at a stage that is feeding the consultants messages about who they should be considering connecting with (hence the name Connections in the app). We are calculating this from data pulled from the internal Jigsaw application that consultants fill out to let RM/others know about their skillsets.
The second app is a matchmaker-on-demand that takes the form of a web applicaiton. You can search for the consultant by name and get their potential matches. The aim for this is to be able to help People People that are looking to match up coaches and coachees along with just having a bit of fun!

## Technical Information

We are currently using Rails as a way to deliver the matchmaker-on-demand app and plan to use whenever to drive the email based notifier. We use a dump of Jigsaw data from early June 2014. To store that data, we are using mongodb.

## Project Team

If you want to participate, join the HipChat team!

## Work in Progress

* Updates from Github
* Connection page - are person A and person B compatible? How compatible? Go to this micro-app to find out

## Future Work

Some other ideas that we had:

* Updates from other services - Twitter, Lanyrd, Meetup, Goodreads, Linkedin
* Dashboards of aggregate data to discover trends - think a Women in Technology dashboard
* Connection badge - integrated into myTW and gives an at-a-glance indication of your connection strength with an individual
