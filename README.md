# Cron Exit Wrapper
A simple script & suggested pipeline for capturing the exit code and journaling the logs from a cron task.

# Usage
* Install exit-check.sh however you wish
  * feel free to modify it, it was written for my specific logging situation
* Reference it with a pipeline like this

```
 * * * * * ubuntu commands 2>&1 | logger -t "test.service"; ./bin/exit-check.sh ${PIPESTATUS[0]} test.service
```



# Collecting logs
This pipeline writes logs to journald, which most log aggregators (Datadog etc) should be able to read in and parse. It's specifically setting a JSON message, but of course this can all be modified to suit your needs.

# Test
test.sh provides a quick mechanism for testing. Just update `test.sh` to your normal user. Run it normally with the pipeline for success, sudo for a failure.

```
sudo ./bin/test.sh 2>&1 | logger -t "test.service"; ./bin/exit-check.sh ${PIPESTATUS[0]} test.service
```

```
Mar 28 19:33:39 devel test.service[2022]: {"ts": "2019-03-28 19:33:39", "level": "ERROR", "message": "You are: root"}
Mar 28 19:33:39 devel test.service[2029]: {"ts": "2019-03-28 19:33:39", "level": "error", "message": "had a non zero exit: 255"}
```

```
./bin/test.sh 2>&1 | logger -t "test.service"; ./bin/exit-check.sh ${PIPESTATUS[0]} test.service
```

```
Mar 28 19:33:26 devel test.service[2013]: {"ts": "2019-03-28 19:33:26", "level": "INFO", "message": "Garbage 48"}
Mar 28 19:33:26 devel test.service[2013]: {"ts": "2019-03-28 19:33:26", "level": "INFO", "message": "Garbage 49"}
Mar 28 19:33:26 devel test.service[2013]: {"ts": "2019-03-28 19:33:26", "level": "INFO", "message": "Garbage 50"}
Mar 28 19:33:26 devel test.service[2018]: {"ts": "2019-03-28 19:33:26", "level": "info", "message": "reported successful completion"}
```