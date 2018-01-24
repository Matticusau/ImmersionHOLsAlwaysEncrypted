# update these values as required for the lab
$sqlServerDNS = '{YOUR DATABASE SERVER DNS NAME HERE}';
$bankAccountNumber = '{BANKACCOUNTNUMBER}';


# import the module
If ((Get-Module -Name SqlServer -ListAvailable) -eq $null)
{
    Install-module -Name SqlServer -Scope CurrentUser
}
Import-Module SqlServer

# Load reflected the required SQL assemblies
[reflection.assembly]::LoadwithPartialName('System.Data.SqlClient') | Out-Null
[reflection.assembly]::LoadwithPartialName('Microsoft.SQLServer.SMO') | Out-Null
[reflection.assembly]::LoadwithPartialName('Microsoft.SQLServer.ConnectionInfo') | Out-Null


# open the database connection
$sqlConn = New-Object -TypeName 'System.Data.SqlClient.SqlConnection';
$sqlConn.ConnectionString = "Server=$($sqlServerDNS);Database=Expenses;User Id=Experience1; Password=P2ssw0rd; Application Name=SimulatedClientApp; Column Encryption Setting=enabled;";
$sqlConn.Open();

# Build the command object
$sqlCmd = New-Object -TypeName 'System.Data.SqlClient.SqlCommand';
$sqlCmd.Connection = $sqlConn;
$sqlCmd.CommandType = [System.Data.CommandType]::StoredProcedure;
$sqlCmd.CommandText = "[Expense].[usp_Employee]";

# Add the parameter of the encrypted column
$sqlCmd.Parameters.Add("@BankAccountNumber", [System.Data.SqlDbType]::NVarChar) | Out-Null;
$sqlCmd.Parameters["@BankAccountNumber"].Size = 17;
$sqlCmd.Parameters["@BankAccountNumber"].Value = $bankAccountNumber;

# run the query
$sqlReader = $sqlCmd.ExecuteReader();
if ($sqlReader.HasRows -eq $false)
{
    Write-Output 'No rows returned';
}
else
{
    # for display purposes we will add the rows to an array and then display that
    [Array]$rows = @()
    while ($sqlReader.Read())
    {
        $rows += [PSCustomObject]@{
                FirstName = $sqlReader.GetValue($sqlReader.GetOrdinal('FirstName'));
                LastName = $sqlReader.GetValue($sqlReader.GetOrdinal('LastName'));
                BankAccountNumber = $sqlReader.GetValue($sqlReader.GetOrdinal('BankAccountNumber'));
            };
       
    }
    $rows | Format-Table;
}
# close the reader
$sqlReader.Dispose();


# close the database connections
$sqlConn.Close();

