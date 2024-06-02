try {
    Import-Module Hyper-V -ErrorAction Stop;
    $listOfVirtualMachines = Get-VM | Where-Object {$_.State -eq 'Running'};
    foreach ($virtualMachine in $listOfVirtualMachines) {
        Write-Host "Shutting down" $virtualMachine;
        Stop-VM -Name $virtualMachine;
    }
    Write-Host "Waiting for 2 minutes...";
    Start-Sleep -Seconds 120;
    foreach ($virtualMachine in $listOfVirtualMachines) {
        $statusOfVirtualMachine = Get-VM -Name $virtualMachine | Select-Object -ExpandProperty State
        Write-Host "Status of" $virtualMachine ":" $statusOfVirtualMachine;
        if ($statusOfVirtualMachine -eq "Off") {
            Write-Host "Starting" $virtualMachine "...";
            Start-VM -Name $virtualMachine;
        }
    }
}
catch [System.IO.FileNotFoundException] {
    Write-Host "Hyper-V module is not installed!";
}


