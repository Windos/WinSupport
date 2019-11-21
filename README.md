# WinSupport - Windows Support Date Lookup Endpoints

Azure Function for looking up Windows (Desktop and Server) support dates.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.svg)](https://azuredeploy.net/?repository=https://github.com/Windos/WinSupport/tree/master)

Check out [Doug Finke's](https://github.com/dfinke) [Awesome Powershell Azure Functions](https://github.com/dfinke/awesome-powershell-azure-functions).

# Some Prerequisites

- [Install .NET Core SDK 2.2+](https://dotnet.microsoft.com/download) (required by Azure Functions Core Tools and available on all supported platforms).
- Install version 2.x of the [Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local#v2).

# How To Run

1. `git clone https://github.com/Windos/WinSupport.git`
1. cd `WinSupport`
1. `func start`
1. Paste into a browser `http://localhost:7071/api/GetDesktopSupportDate?Version=6.3`

# Credit

Thanks to @dfinke for the [README inspiration](https://github.com/dfinke/powershell-azure-function-helloworld).
