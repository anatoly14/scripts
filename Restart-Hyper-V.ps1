try {
    Import-Module Hyper-V -ErrorAction Stop;
    $listOfVirtualMachines = Get-VM | Where-Object {$_.State -eq 'Running'};
    foreach ($virtualMachine in $listOfVirtualMachines) {
        Write-Host "Shutting down" $virtualMachine;
        Stop-VM -Name $virtualMachine;
        $statusOfVirtualMachine = Get-VM -Name $virtualMachine | Select-Object -ExpandProperty State
        if ($statusOfVirtualMachine -eq "Off") {
            Write-Host "Starting up" $virtualMachine;   
            Start-VM -Name $virtualMachine;
        }
    }
catch [System.IO.FileNotFoundException] {
    Write-Host "Hyper-V module is not installed!";
}


