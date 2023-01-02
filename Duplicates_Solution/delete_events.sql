DELETE FROM
    events a
        USING events b
WHERE
    a.connected_at < b.connected_at
    AND a.disconnected_at IS NULL 
    AND b.disconnected_at IS NULL;