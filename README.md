## km-export-processor gem

The purpose of this gem is to consume the JSON that KISSmetrics exports to an S3 bucket, and transform it in a variety of useful ways.

The core features are:

* *JSON compiler* : Aggregates all KISSmetrics JSON files in a directory, into a single (nonstandard) file.
* *JSON to JSON converter* : Converts a nonstandard JSON file into standard format.
* *JSON to CSV converter* : Converts a nonstandard JSON file into a CSV file, where each row is an event/property/alias.
* *Reimporter* : Takes a nonstandard JSON file, and an API key, and sends the data in the JSON file to the product using the KMTS gem.
* *Alias parser* : Takes a nonstandard JSON file, and separates out any alias calls into their own JSON file, to be processed separately.
* *Email parser* : Takes a nonstandard JSON file, and an identity. Parses any actions done by the identity in the JSON file, into a separate file.

### Installing

```
$ gem install km-export-processor -v 0.3.6
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
$ km-export-processor json_compiler
$ km-export-processor json_to_json [JSONFILE]
$ km-export-processor json_to_csv [JSONFILE]
$ km-export-processor parse_aliases [JSONFILE]
$ km-export-processor parse_identity [JSONFILE] [IDENTITY]
$ km-export-processor reimport [JSONFILE] [APIKEY] [OFFSET]
```
They assume that you are running them from the directory in which all the JSON files are downloaded, and output their files to that same directory. The words inside brackets [] are parameters, to be replaced with the name of the JSON file in question, and the API key to be used.

The typical workflow for using this gem would look like this:
* Download KISSmetrics JSON files from the S3 bucket.
* Compile JSON files into single file:
```
$ km-export-processor json_compiler
```
* Perform any parsing/conversions on the resulting compiled file:
```
$ km-export-processor json_to_csv 1396895233_result.json
$ km-export-processor json_to_json 1396895233_result.json
$ km-export-processor parse_identity 1396895233_result.json test@test.com
```

*Keep in mind that all parsers and converters use the nonstandard KISSmetrics JSON as input. If you want to use any JSON in another application (like Excel), you are going to have to run the nonstandard JSON file through the json_to_json converter.*


### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request