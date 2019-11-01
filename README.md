# Trello Archiver

Tool to archive trello column(s) to google docs for historical records

## Setup

## trello_sprint.yml

Make a copy og `trello_sprint.yml.org` to `trello_sprint.yml`. You'll need to replace the list_id with the column you wish to pull from Trello.

### Trello

You'll need to set up a Trello API key and oauth secret. You can find the instructions [here](https://trello.com/app-key)

Save these to a file: `~/.trello_auth_sprint_info.yml` as follows:

```
---
:public_key: XXXXXXX
:token: XXXXXXXXX
```

### Gdoc

The authentication process will save the files you need the first time you run it, just follow the instructions in the console.

## Run in Console Mode

To run the tool to output to the console, navigate to the project directory and run:

`./bin/trello_sprint_info  --length 2` (where length is the sprint length in weeks)

## Run in GDoc Mode

To run the tool to output to gdocs, run:

`./bin/trello_sprint_info  --length 2 --gdoc`

## Developer Setup

In the console run:

`chruby 2.6.3` to set the ruby version

`bundle install` to install dependencies
