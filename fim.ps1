Function Calculate-File-Hash($filepath){
    $filehash = Get-FileHash -Path $filepath -Algorithm SHA512
    return $filehash
}

Function Erase-Baseline-If-Already-Exists(){
    $baselineexists = Test-Path -Path C:\Users\arjun\OneDrive\Desktop\baseline.txt

    if($baselineexists){
        #Delete it
        Remove-Item -Path C:\Users\arjun\OneDrive\Desktop\baseline.txt
    }
}

Write-Host ""
Write-Host "What would you like to do?"
Write-Host ""
Write-Host "A) Collect new baseline?"
Write-Host ""
Write-Host "B) Begin monitoring files with saved baseline"
Write-Host ""

$response = Read-Host -Prompt "Please enter A or B"
Write-Host ""

if($response -eq "A".ToUpper()){
    #Erase baseline if it already exists
    Erase-Baseline-If-Already-Exists

    #Calculate hash of the files and store it in the baseline.txt

    #Collect all files in the target folder
    $files = Get-ChildItem -Path C:\Users\arjun\OneDrive\Desktop\FIM

    #For each file, calculate the hash, and write to baseline.txt
    foreach($f in $files){
        $hash = Calculate-File-Hash $f.FullName
        "$($hash.Path)|$($hash.Hash)" | Out-File -FilePath C:\Users\arjun\OneDrive\Desktop\baseline.txt -Append
    }
}


elseif($response -eq "B".ToUpper()){
    #Load file|hash from baseline and store them in a dictionary
    $filehashdict = @{}
    $filepathsandhashes = Get-Content -Path C:\Users\arjun\OneDrive\Desktop\baseline.txt
    
    foreach($f in $filepathsandhashes){
      $filehashdict.add($f.Split("|")[0],$f.Split("|")[1])  
    }

    $filehashdict.Values
    
    #Begin (continuously) monitoring hash with saved baseline(Infinite loop)
    while($true){ 
        Start-Sleep -Seconds 1
        
        $files = Get-ChildItem -Path C:\Users\arjun\OneDrive\Desktop\FIM

        foreach($f in $files){
            $hash = Calculate-File-Hash $f.FullName
            if($filehashdict[$hash.Path] -eq $null){
               # A new file has been created!(Path doesn't exist
               Write-Host "$($hash.Path) has been created" -ForegroundColor Green 
            }
            else{
               #Check if the file has changed
               if($filehashdict[$hash.Path] -eq $hash.Hash){
                    # File not modified
               }
               else{
                    #File was compromised
                    Write-Host "$($hash.Path) has been modified" -ForegroundColor Yellow
               } 
            }
        }

        foreach($key in $filehashdict.Keys){
            $fileexists = Test-Path -Path $key
            if(-Not $fileexists){
                #One of the baseline files have been deleted
                Write-Host "$key has been deleted" -ForegroundColor Red

            }
        }
    }
        
}