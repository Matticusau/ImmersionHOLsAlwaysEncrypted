-- Always Encrypted Demo

-- Create an Extended Events session to capture rpc_completed event for sp_executesql statements
CREATE EVENT SESSION [AlwaysEncrypted] ON SERVER 
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlserver.client_app_name,sqlserver.sql_text)
    WHERE ([object_name]=N'sp_executesql' OR [object_name]=N'usp_Employee'))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO

-- Run a client query, even from SSMS and then have a look at the captured event and how the value is encrypted by the client
