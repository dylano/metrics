SELECT [CD-SH-DeviceID], hittimestamp, ( 
	CASE 
		WHEN arch = '1d0038000347353138383138'  -- Device 5a
		THEN 1 
		WHEN arch = '36001e000447353138383138'  -- Device 5b
		THEN 2 
		ELSE 0 
	END ) + ( 
	CASE 
		WHEN eventAction = 'click' 
		THEN -.2
		WHEN eventAction = 'longpress' 
		THEN .2
		ELSE 0 
	END ) AS plotline,   -- assign a Y-value to each device/click combo in order to scatterplot
	CASE 
		WHEN eventAction = 'click' 
		THEN 'Rainbow' 
		WHEN eventAction = 'doubleclick' 
		THEN 'Yellow Green' 
		WHEN eventAction = 'longpress' 
		THEN 'Blue' 
		ELSE '' 
	END AS ClickType 
FROM [121095747.AllEvents_30Day] 
WHERE appname = 'smart_home' 
	AND arch IN ( '1d0038000347353138383138' , '36001e000447353138383138' )  -- Device pair 5
	AND eventcategory IN ( 'DEVICE_1_BUTTON_PRESS' , 'DEVICE_2_BUTTON_PRESS' )
