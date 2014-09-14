fs = require 'fs'
sleep = require('sleep');
program = require 'commander'
LineByLineReader = require('line-by-line')
elasticsearch = require('elasticsearch')


program
  .option('--day [day]', 'the day')
  .option('--index [index]', 'the ES index')
  .option('--type [type]', 'the ES type of index')
  .option('--host [host]', 'the host attribute')
  .option('--path [path]', 'the path attribute')
  .option('--batch [batch]', 'batch size', parseInt)
  .option('--sleep [sleep]', 'to sleep macroseconds', parseInt)
  .parse(process.argv)

client = new elasticsearch.Client
  host: 'localhost:9200',
  log: 'warning'

lr = new LineByLineReader(program.args[0]);

pattern = /(\w+)\s+\[(\w+)\s*\]\s+<(\d{2}:\d{2}:\d{2})>\s+(.+)/
message = null
timestamp = null
category = null
level = null

buffer = []
lr.on "line", (line) ->
  m = pattern.exec line
  if not m
    # append to buffer
    message += " | " + line.trim() if message
  else 
    if message
      obj =
        timestamp : timestamp
        category: category
        level: level
        host: program.host
        path: program.path
        message: message
        raw_message : message

      # console.log obj

      buffer.push obj
      if buffer.length >= program.batch
        console.log "bulk index document"
        # lr.pause()
        bulk_body = []
        for o in buffer
          bulk_body.push {index: { _index: program.index, _type: program.type}}
          bulk_body.push o
        buffer = []
        sleep.usleep(1000 * program.sleep)
        client.bulk
          body:
            bulk_body 
        , (err, resp) ->
            if err
              console.log err.stack
            # console.log resp
            # lr.resume()


    message = m[4]
    timestamp = program.day + "T" + m[3]
    category = m[2].trim()
    level = m[1]





