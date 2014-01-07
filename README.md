## km-export-processor gem

The purpose of this gem is to consume the JSON that KISSmetrics exports to an S3 bucket, and transform it in a variety of useful ways.

The core features are:

* *JSON to JSON converter* : Converts the non-standard KISSmetrics JSON files into one larger, standard file.
* *JSON to CSV converter* : Converts standard JSON file into a CSV file, where each row is an event/property/alias.
* *Reimporter* : Takes a standard JSON file, and an API key, and sends the data in the JSON file to the product using the KMTS gem.
* *Alias parser* : Takes a standard JSON file, and separates out any alias calls into their own JSON file, to be processed separately.

### Installing

```
$ gem install km-export-processor
```

### Usage

*First, use the terminal to navigate to the location where the KM JSON files were downloaded*
```
$ cd Documents/km-export
```

*Next, run the gem at the command line to see the available commands, and their usage*
```
$ km-export-processor
```

*Available commands are:*

```
$ km-export-processor json_to_json
$ km-export-processor json_to_csv [JSONFILE]
$ km-export-processor parse_aliases [JSONFILE]
$ km-export-processor reimport [JSONFILE] [APIKEY]
```
They assume that you are running them from the directory in which all the JSON files are downloaded, and output their files to that same directory. The words inside brackets [] are parameters, to be replaced with the name of the JSON file in question, and the API key to be used.
