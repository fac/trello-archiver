# Trello Archiver

Tool to archive trello column(s) to google docs for historical records

Run `./bin/trello_sprint_info -h` for usage options.

## Setup

### trello_sprint.yml

Make a copy of `trello_sprint.yml.org` to `trello_sprint.yml`. You'll need to replace the list_id with the column you wish to pull from Trello.

### Trello

You'll need to set up a Trello API key and oauth secret. You can find the instructions [here](https://trello.com/app-key)

You can automatically do this by running: `./bin/trello_sprint_info -t` and following the on-screen instructions.

Save these to a file: `~/.trello_auth_sprint_info.yml` as follows:

```
---
:public_key: XXXXXXX
:token: XXXXXXXXX
```

### Gdoc

Get the `spreadsheet_id` field of your spreadsheet and add it to relevant field in the `trello_sprint.yml` file.

Talk to one of the existing devs to get a copy of their `~/.gdoc_credentials.json`.

Run the tool in GDoc mode (See below).

The authentication process will save the files you need the first time you run it, just follow the instructions in the console.

## Run in Console Mode

To run the tool to output to the console, navigate to the project directory and run:

`./bin/trello_sprint_info  --length 2` (where length is the sprint length in weeks)

## Run in GDoc Mode

To run the tool to output to gdocs, run:

`./bin/trello_sprint_info  --length 2 --gdoc`

## Specify config file

To use a config file that is not the default, use the `-c` command line switch.

`./bin/trello_sprint_info -c ./trello_sprint.yml`

## Developer Setup

In the console run:

`chruby 2.6.3` to set the ruby version

`bundle install` to install dependencies
