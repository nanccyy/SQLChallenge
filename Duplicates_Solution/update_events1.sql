with cte as (
	select
		device_id 
		, connected_at 
		, disconnected_at 
		, lead(connected_at) over (partition by device_id order by connected_at asc) "nextConnection"
	from
		events
	order by
		device_id
		, connected_at desc 
)
	update
		events
	set
		disconnected_at = cte."nextConnection"
	from
		cte
	where
		events.device_id = cte.device_id
		and events.connected_at = cte.connected_at
		and events.disconnected_at is null
