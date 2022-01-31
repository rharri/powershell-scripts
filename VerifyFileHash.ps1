# Simple file hash verification script

# Usage:
# 1. Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
# 2. Run script
# 3. Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser -Force
# 4. Get-ExecutionPolicy -List

try
{
    if ($args.Count -ne 3)
    {
        Write-Host "Expected 3 arguments."
        Write-Host "Usage: [path] [algorithm] [hash]"
        Return
    }

    $path = $args[0]
    $algo = $args[1]
    $hash = $args[2]

    if (-not(Test-Path $path))
    {
        Write-Host "Invalid path. Check path and try again."
        Return
    }

    $algorithms = @("SHA1", "SHA256", "SHA384", "SHA512", "MD5")
    if (-not($algorithms -contains $algo))
    {
        Write-Host "Unsupported algorithm."
        Write-Host "Supported: " $algorithms
        Return
    }

    $result = Get-FileHash $path -Algorithm $algo

    if ($result.Hash -eq $hash)
    {
        Write-Host "Result: Ok"
        Write-Host "Path: " $result.Path
        Write-Host "Algorithm: " $algo
        Write-Host "File Hash: " $result.Hash
        Write-Host "Your Hash: " $hash.ToUpper()
    } else {
        Write-Host "Result: Bad"
    }
}
catch
{
    Write-Host "An error occured."
}