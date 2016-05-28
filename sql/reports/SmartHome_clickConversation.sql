select
  [CD-SH-DeviceID],

hittimestamp, 

(  case
    when arch = '1d0038000347353138383138'
      then 1
    when arch = '36001e000447353138383138'
      then 2
    else 0
  end )
+
(case
    when eventAction = 'click'
      then -.2
    when eventAction = 'longpress'
      then .2
    else 0
  end 
) as plotline,

case
    when eventAction = 'click'
      then 'Rainbow'
    when eventAction = 'doubleclick'
      then 'Yellow Green'
    when eventAction = 'longpress'
      then 'Blue'
    else ''
  end as ClickType




from
  [121095747.SH_Events]
where
  appname = 'smart_home'
  and arch in (
    '1d0038000347353138383138'
    , '36001e000447353138383138'
  )
  and eventcategory in (
    'DEVICE_1_BUTTON_PRESS'
    , 'DEVICE_2_BUTTON_PRESS'
  )
