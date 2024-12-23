# Sample program

## Files
Input files

### Procedure costs
Procedure code, cost\
X(3) 99999V99\
`AB1 0012351`  E.g. $123.51

Q: What about vendor ? Procedure cost might depend on vendor. Also cost may change by date.

### Customer
SSN, first name, last name\
`888123456Matthew    Blacksmith`

### Taxes file
1. Tax per state:
- State, tax rate\
California 8.45%\
`CA0845`
2. Tax per state, procedure
- State, Procedure code, tax rate

### Insurance
SSN, procedures
Procedures are in one line, each 3 alphanumeric, can occur multiple times
E.g.:\
`888123456 AB1CX5P01P02P03P04P11`\
`777123456 AB2CZYP03P04P12`

Q: How to figure out that one customer may have coverage for X number of procedures, while the other customer may have coverage for Y number of procedures ? X != Y and both X and Y maight be finite, but big.

### Claims
Read claims file, connect with customer file and procedure cost and insurance file
Produce claims coverage file and store in separate file for each vendor
SSN, first name, last name, covered procedures, coverage cost\
`888123456Matthew    Blacksmith   62378`\
`CX5P02P03P04`\
Q: List of covered procedures can vary, could be 0. How to figure out where to store it?.\
Costs is 99999V99.


application -> costs file, customer file, insurance file, taxes file -> send files to goverment, accountants, vendors, medical facilities -> receive claims or confirmations -> associate them with customers records (organize by folders for example)
