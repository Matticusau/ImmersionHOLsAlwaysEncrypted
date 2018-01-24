-- Create the stored procedure for our sample client to use
USE Expenses
GO
CREATE PROCEDURE [Expense].[usp_Employee]
(
	@BankAccountNumber NVARCHAR(17)
)
AS
	SELECT e.Id
		, e.FirstName
		, e.LastName
		, e.Email
		, e.Identifier
		, e.JobTitle
		, e.TeamId
		, e.IsTeamManager
		, e.BankAccountNumber
	FROM [Expense].[Employee] e
	WHERE e.[BankAccountNumber] = @BankAccountNumber

GO