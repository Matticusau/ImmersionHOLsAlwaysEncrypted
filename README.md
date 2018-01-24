# Always Encrypted HOL - Client Demo Extension
These files enhance the client demonstration part of the Hands On Lab for Always Encrypted as part of the Immersion Labs. For more information see [http://www.microsoft.com/handsonlabs](http://www.microsoft.com/handsonlabs)

## Instructions

1. Run through the lab as per normal to setup Always Encrypted
2. Create a new connection within SSMS, ensuring that you set the `Column Encryption Setting=enabled` in your connection properties.
3. Run **ExtendedEventsSessionSetup.sql** from SSMS to create a session to monitor/capture the queries
4. Run a `SELECT * FROM [Expense].[Employee]` and copy an unencrypted BankAccountNumber value from your data. Use that value in the following scripts as needed.
5. Run the **SampleClientSSMS.sql** from SSMS, make sure you enable the `Enable Parameterization for Always Encrypted` option as per the instructions
6. Check the Extended Events session to view how the query data is encrypted in flight
7. Open PowerShell ISE and run the **SampleClient.ps1** script, which will simulate a different client. Make sure you update the variables first.
8. Check the Extended Events session to view how the query data is encrypted in flight

