# gym2tcx - convert gymData XML files into TCX

## How to use

    ./process.sh /path/to/gymdata.xml

Output will be the corresponding TCX file in the current directory.

## Requires

xsltproc with exslt date extensions

How to check:

    > xsltproc --dumpextensions | grep add
    ...
    {http://exslt.org/dates-and-times}add
    ...

## Compatibility

The output TCX has been checked against [Garmin's v2 schema](http://www8.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd) using xmllint.

### Uploads perfectly

* ridewithgps

### Uploads with minor issues

* Strava (no calories)
* MapMyTracks (no calories)
* RunningFreeOnline (no heartrate)

### Uploads with major issues

* MapMyRide (no graphs)
* Endomondo (no speed)

### Doesn't upload

* Garmin Connect
* Runkeeper
