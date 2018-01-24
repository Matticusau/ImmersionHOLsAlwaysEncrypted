 /*
 The following will simulate a client connecting with Always Encrypted

 1. Open a new connection in SSMS ensuring to add the 'Column Encryption Setting=enabled' to the connection properties
 2. Turn on the 'Enable Parameterization for Always Encrypted' Query Option
 3. Start an Extended Events session (see related script)
 4. Execute this script and notice the data returned is unencrypted
    also check the way the query data is encrypted in flight though with Extended Events Session

*/
DECLARE @BankAccountNumber NVARCHAR(17) = N'{BANKACCOUNTNUMBER}'
SELECT * FROM [Expense].[Employee] WHERE BankAccountNumber = @BankAccountNumber