<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date"
>
      <xsl:output method="xml" indent="yes"/>
      <xsl:variable name="start"><xsl:value-of select="//openTime"/></xsl:variable>
      <xsl:variable name="end"><xsl:value-of select="//closeTime"/></xsl:variable>
      <xsl:variable name="sdt"><xsl:value-of select="date:seconds($start)"/></xsl:variable>
      <xsl:variable name="cdt"><xsl:value-of select="date:seconds($end)"/></xsl:variable>
      <xsl:variable name="lkm"><xsl:value-of select="(//km)[last()]"/></xsl:variable>
      <xsl:variable name="lkc"><xsl:value-of select="(//kCal)[last()]"/></xsl:variable>
<xsl:variable name="sumBPM" select="sum(//interval/bpm)"/>
<xsl:variable name="countBPM" select="count(//interval/bpm)"/>
<xsl:variable name="vMaxBPM">
  <xsl:for-each select="//interval">
    <xsl:sort select="bpm" data-type="number" order="descending" />
    <xsl:if test="position() = 1">
      <xsl:value-of select="bpm"/>
    </xsl:if>
  </xsl:for-each>
</xsl:variable>

      <xsl:template match="/">

          <TrainingCenterDatabase xmlns="http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.garmin.com/xmlschemas/ActivityExtension/v2 http://www.garmin.com/xmlschemas/ActivityExtensionv2.xsd http://www.garmin.com/xmlschemas/FatCalories/v1 http://www.garmin.com/xmlschemas/fatcalorieextensionv1.xsd http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2 http://www.garmin.com/xmlschemas/TrainingCenterDatabasev2.xsd" xmlns:ns3="http://www.garmin.com/xmlschemas/ActivityExtension/v2">
            <Activities>
                <Activity Sport="Other">
                    <Id><xsl:value-of select="$start"/></Id>
                    <Lap StartTime="{$start}">
                        <TotalTimeSeconds><xsl:value-of select="$cdt - $sdt"/>.00</TotalTimeSeconds>
                        <DistanceMeters><xsl:value-of select="1000*$lkm"/>.00</DistanceMeters>
                        <Calories><xsl:value-of select="$lkc"/></Calories>
<xsl:if test="$countBPM > 0">
<AverageHeartRateBpm><xsl:value-of select="$sumBPM div $countBPM"/></AverageHeartRateBpm>
</xsl:if>
<MaximumHeartRateBpm><xsl:value-of select="$vMaxBPM"/></MaximumHeartRateBpm>
                        <Intensity>Active</Intensity>
                        <TriggerMethod>Manual</TriggerMethod>
                        <Track>
                        <xsl:for-each select="//interval">
                            <Trackpoint>
                                <xsl:if test="sec">
                                    <Time><xsl:value-of select="date:add($start,concat('PT',sec,'S'))"/></Time>
                                </xsl:if>
                            <xsl:if test="km">
                                <DistanceMeters><xsl:value-of select="1000*km"/></DistanceMeters>
                            </xsl:if>
                                <xsl:if test="bpm">
                                <HeartRateBpm xsi:type="HeartRateInBeatsPerMinute_t">
                                    <Value><xsl:value-of select="bpm"/></Value>
                                </HeartRateBpm>
                            </xsl:if>
                            <xsl:if test="spm">
                                <Cadence><xsl:value-of select="spm"/></Cadence>
                            </xsl:if>
                            </Trackpoint>
                        </xsl:for-each>
                        </Track>
                        <Extensions>
          <LX xmlns="http://www.garmin.com/xmlschemas/ActivityExtension/v2">
            <AvgSpeed>2.9200001</AvgSpeed>
          </LX>
      </Extensions>
  </Lap>
                    <Creator xsi:type="Device_t">
                        <Name><xsl:value-of select="//manufacturerName"/>:<xsl:value-of select="//model"/></Name>
                        <UnitId>43</UnitId>
                        <ProductID>43</ProductID>
                        <Version>
                            <VersionMajor>0</VersionMajor>
                            <VersionMinor>1</VersionMinor>
                        </Version>
                    </Creator>
                </Activity>
            </Activities>
            <Author xsi:type="Application_t">
                <Name>gym2tcx</Name>
                <Build>
                    <Version>
                        <VersionMajor>0</VersionMajor>
                        <VersionMinor>1</VersionMinor>
                    </Version>
                    <Builder><xsl:value-of select="//serialNumber"/></Builder>
                </Build>
                <LangID>en</LangID>
                <PartNumber>888-A8888-88</PartNumber>
            </Author>
        </TrainingCenterDatabase>
      </xsl:template>
</xsl:stylesheet>
