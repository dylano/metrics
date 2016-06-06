SELECT
  STRFTIME_UTC_USEC(visitstarttime * 1000000 + hits.time*1000, "%F %T") AS HitTimestamp,
  visitstarttime*1000000 + hits.time*1000 AS HitTimestampUsec,
  max(case when hits.customdimensions.index = 7 then hits.customdimensions.value end) EventTimestamp,
  FullVisitorId,
  VisitId,
  VisitNumber,
  hits.hitNumber as HitNumber,
  hits.appinfo.name as AppName,
  hits.eventInfo.eventCategory as EventCategory,
  hits.eventInfo.eventAction as EventAction,
  hits.eventInfo.eventLabel as EventLabel,
  hits.eventInfo.eventValue as EventValue,
  max(case when hits.customdimensions.index = 8 then hits.customdimensions.value end) EventValueFP,
  max(case when hits.customdimensions.index = 1 then hits.customdimensions.value end) OS,
  max(case when hits.customdimensions.index = 2 then hits.customdimensions.value end) OSVersion,
  max(case when hits.customdimensions.index = 3 then hits.customdimensions.value end) Device,
  max(case when hits.customdimensions.index = 4 then hits.customdimensions.value end) Arch,
  max(case when hits.customdimensions.index = 5 then hits.customdimensions.value end) AppPlatform,
  max(case when hits.customdimensions.index = 6 then hits.customdimensions.value end) AppBuildID

FROM 
  (TABLE_DATE_RANGE([121095747.ga_sessions_], DATE_ADD(CURRENT_TIMESTAMP(), -6, 'DAY'), DATE_ADD(CURRENT_TIMESTAMP(), -1, 'DAY'))),
  (TABLE_DATE_RANGE([121095747.ga_sessions_intraday_], DATE_ADD(CURRENT_TIMESTAMP(), -7, 'DAY'), CURRENT_TIMESTAMP()))

WHERE
  hits.eventInfo.eventValue is not null

GROUP EACH BY 
  hits.hitnumber, hitnumber, hitTimestamp, hitTimestampUsec, visitid, visitnumber, appName, eventCategory, eventAction, eventLabel, eventValue, fullVisitorId

ORDER BY 
  hitTimestampUsec
