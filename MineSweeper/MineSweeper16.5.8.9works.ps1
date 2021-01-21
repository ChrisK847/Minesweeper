<#

########
#ISSUES#
########



   ################ 
   #ActuallyBroken#
   ################
        
        #Image doesn't go to top on win or lose. (Needs confirmation if this still exists)
        #Profile Form doesn't always go to the top window.
        #Leaderboard in Game shows 0.4 seconds for Chris on 09/07/2020 with 5 rows on Medium

        

   ############
   #Aesthetics#
   ############

        #Have the music loop through all songs in a random order without replaying the same song twice in a row.
        #Add more songs to the playlist
        #Have same song continue to play where it left off after end-of-round.
        

        
   ##############
   #Optimization#
   ##############
        
        
  
   
   ###############         
   #Functionality#
   ############### 

        #Create Multiplayer mode
        #Create Items
            #Armor
            #C4 - More difficult to use?
                Perhaps my inventory items cycle through as I right click? Then when clicked it's applied? 
            #Vehicles
            #Health/food
            #Victims
            #Gold
            #Special items
            #Weapons
            #ABV (Assualt Breacher Vehcile)
            #APOBS (Anti-personel Obstacle Breaching System)
            #Keys
        #Carry over items to next round or career

        #Select number of bombs. Remove Difficulty
            Maybe this is required to make it fair in multiplayer mode. Alternative, if a player has more bombs/obstacles, perhaps they are compensated in other ways.
        #Button to clear all stats
        #Allow user to choose avatar
        #Scenarios
            #Add different images for each scenario
            #Add mission/scenario instructions
                #Use real battleground names for some maps
            #Characters
                #Military Characters
                #Kid at home, parents
        #Promotions
        #Bonuses
        #Side Missions, Bonus Missions
            #Flip a coin/card for bonuses or to reveal squares
        #In situations where there is 50/50 chance of bomb, allow user to choose another method of revealing bomb
        #Save game state
        #If adjacent folders/files are missing, recreate them using main file.


    ##################
    #Make Better Code#
    ##################

        #In forms, set left and top control location based on invisible items. The issue is that changing my label will mean that all dependent controls will `
            move with it.
        #Rename variables and functions to make more sense
        #Add comments describing what each function does.
        #Use common practices, such as . (dot) naming instructions and such.
        #remove imports prior on rerun to make editing easier.
        #have images automatically resize based on button size/resolution


    #######
    #FIXED#
    #######

    #Need to find out why when clicking back in Settings Form, that User Form automatically is set to Player 1. Should only happen on null or missing profile name.
    #When changing and even saving settings in Settings Form, then clicking PlayNow, it does not pickup the new settings.
    #Began fixing backend of config buttons.
    #Need to determine why back button in Game Form sometimes gray's out.
    #Need to test Game Form buttons and scenarios.
    #Need find and fix when script goes into endless loop.
    #Game Form Back Button sometimes has Adjacent bombs
    #Bomb image shows up too quickly, bomb sound shows up after explosion
    #Show bombs after winning round.
    #Stop Timer after round end
    #Every Round now has bombs
    #Convert Paths from static to dynamic
    #Disabled buttons after winning round.
    #Added Stats
    #Game match where one square remained uncovered after winning.
    #Game stats are not being updated in game form
    #Fixed stats issue where if no available top score a popup alerts the player of this.
    #Fixed config issue within GetGV and SetGV where similar user names were pulling each other's stats. e.g. "Chris" pulls "Chris" and "Chris and Savina"
    #Why does the timer not work properly in games. No way my last game was 9 seconds in length.
    #A way to mark known bombs in game play - Right Click?
    #Adjust stats so that Leaderboard is based on number of bombs rather than difficulty setting
    #Adjust stats so that Leaderboard is based on number of bombs rather than difficulty setting
        As of now, it is only pulling unique seconds rather than all best times. So, it's show leaders with 3, 4, and 5 seconds rather than 3, 3, 3
    #Adjust stats to show tenth of a second.
    #line 107 CAN I FILTER FOR ROW AND DIFFICULTY AS I IMPORT TO SAVE TIME? ANSWER: Change backed out. It wasn't faster attempting to import WinLose for only Win's.
    #Not an issue, but combine all imports into a single section and only import once, but also 
    #Add Exit button and restart button to Game Form
    #When Clicking restart after beating a game, the stats are not uploaded to the leaderboard.
    #Rename back button on Options form. Back to what?
    #QuickMatch should be played as the selected profile
    #Sort stats Rows in ascending order
    #Smaller buttons should call smaller background pictures
    #Create more contrast between clicked and unclicked buttons
    #Add larger background image to larger buttons
    #Create larger bomb image for background bomb
    #Stats are showing games played with 0 bombs; even winning games, see 9/6/2020 22:16:12 in stats
    #Added Save State Button
    #Added Load State Button
    #Added Multiplayer Button
    #Add random checkbox on user form to play random map rather than user default settings
    #Add music
    #Update Music logic, so that if you had started a game, and you click Give UP, you change settings, and play again, that the same music is still playing if...
        the song hadn't completed from the previous time that it was started.

#########
#SOURCES#
#########

    # Colors
    #https://docs.microsoft.com/en-us/dotnet/api/microsoft.windows.powershell.gui.internal.colornames?view=powershellsdk-1.1.0
    #Explosion image
    #https://cdn.pixabay.com/photo/2017/05/24/13/05/comic-2340467_960_720.png
    #Create Bomb Image
    #https://stackoverflow.com/questions/2067920/can-i-draw-create-an-image-with-a-given-text-with-powershell
    #Form Border Styles
    #https://docs.microsoft.com/en-us/dotnet/api/system.windows.forms.formborderstyle?view=netcore-3.1


#>


Function Timer_Tick(){
   ++$Script:timerCount
   if($($Script:timerCount / 10) % 1 -eq 0){
        $objForm.Text = "MINESWEEPER - $user : $Difficulty : Mute=$mute : Time=$($Script:timerCount / 10)"
        if($($script:timerCount / 10) % 5 -eq 0){
            media3 $script:soundPath $script:musicPlaylist $script:mute
        }
   }
}


Function Stats(){
    #write-host "stats"
    switch($($script:difficulty/1)){
        1 {$difficulty = "Easy"}
        2 {$difficulty = "Medium"}
        3 {$difficulty = "Hard"}
    }
#write-host $("47 $($script:user), $($script:winLose), $($script:score), $($script:win), $($script:timerCount), $difficulty, $($script:numRows), $($script:totalBombs)")
#write-host $($($script:winLose).length)
    $stats += [PScustomobject]@{
        Date=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{(Get-Date -Format "MM/dd/yyyy HH:mm:ss")};
        User=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$($script:user)};
        WinLose=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:winLose};
        YourPoints=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:score};
        PossiblePoints=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:win};
        Percentage=$( if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{Try{$($script:score/$script:win).toString("P")}catch{""}} );
        TimeInSeconds=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$($Script:timerCount / 10)};
        Difficulty=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$difficulty};
        Rows=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:numRows};
        #Bombs=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:totalBombs}; 9/3
        Bombs=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$script:statsBombs}; #9/3
        Squares=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$($($script:numRows/1)*$($script:numRows/1))};
        BombSqaureRatio=if($script:winLose -eq $null -or $script:winLose -eq "0" -or $script:winLose -eq 0 -or $script:winLose -eq ""){""}else{$($($($script:totalBombs/1)/$($($script:numRows/1)*$($script:numRows/1))).ToString("P"))};
    }
    If(Test-Path "$psscriptroot\Stats\GameStats.csv"){
        $careerStats = Import-Csv -Path "$psscriptroot\Stats\GameStats.csv" #WHAT IS CAREER STATS USED FOR?
        $stats | Export-Csv -NoTypeInformation "$psscriptroot\Stats\GameStats.csv" -Append -Force
    }else{
        $stats | Export-Csv -NoTypeInformation "$psscriptroot\Stats\GameStats.csv" -Append -Force
        #$careerStats = Import-Csv -Path "$psscriptroot\Stats\GameStats.csv"
        #write-host $($CareerStats | ft *| Out-String)
    }
}


Function GetStats($bombs,$Rows,$Allstats){ #USED TO CONVERT STRINGS AS NUMBERS TO INTEGERS
    #$m = Measure-Command{
        #write-host "b=$bombs, r=$Rows, a=$Allstats"
        #write-host "d=$($Difficulty.gettype()), r=$($Rows.gettype()), a=$($Allstats.gettype())"
        
        #$watch =  [system.diagnostics.stopwatch]::StartNew()
        #write-host $("before import $($watch.Elapsed.ToString("ss"))")

#IMPORT CSV AND TYPECAST
<#
        $csv = Import-Csv "$PSScriptroot\Stats\GameStats.csv" | 
        Select @{Name="Date";Expression={$([datetime]$($_.Date)).ToString("MM/dd/yyyy").Trim()}}, `
        User, `
        WinLose, `
        @{Name="PossiblePoints";Expression={[int]$_.PossiblePoints}}, `
        Percentage, `
        @{Name="TimeInSeconds";Expression={[int]$_.TimeInSeconds}}, `
        Difficulty, `
        @{Name="Rows";Expression={[int]$_.Rows}}, `
        @{Name="Bombs";Expression={[int]$_.Bombs}}, `
        @{Name="Squares";Expression={[int]$_.Squares}}, `
        BombSqaureRatio
#>  
        #write-host $("97 $($script:user), $($script:winLose), $($script:score), $($script:win), $($script:timeCount), $difficulty, $($script:numRows), $($script:totalBombs)")
        #CAN I FILTER FOR WIN, ROW AND DIFFICULTY AS I IMPORT TO SAVE TIME?
        
        #@{Name="Date";Expression={$([datetime]$($_.Date)).ToString("MM/dd/yyyy").Trim()}}, `
        #WinLose, `
        #@{Name="WinLose";Expression={$_.WinLose | Where-Object{$_ -like "Win"}}}, `
            Try{
                $csv = Import-Csv "$PSScriptroot\Stats\GameStats.csv" | 
                Select @{Name="Date";Expression={$([datetime]$($_.Date))}}, `
                User, `
                WinLose, `
                @{Name="TimeInSeconds";Expression={[double]$_.TimeInSeconds}}, `
                @{Name="Rows";Expression={[int]$_.Rows}}, `
                @{Name="Bombs";Expression={[int]$_.Bombs}} #9/3
                
                #write-host $("107 $($script:user), $($script:winLose), $($script:score), $($script:win), $($script:timeCount), $difficulty, $($script:numRows), $($script:totalBombs)")
            }catch{
                #write-host $("109 $($script:user), $($script:winLose), $($script:score), $($script:win), $($script:timerCount), $difficulty, $($script:numRows), $($script:totalBombs)")        
                stats
                #$csv = Import-Csv "$PSScriptroot\Stats\GameStats.csv" | 
                #Select @{Name="Date";Expression={$([datetime]$($_.Date)).ToString("MM/dd/yyyy").Trim()}}, `
                #User, `
                #WinLose, `
                ##@{Name="TimeInSeconds";Expression={[int]$_.TimeInSeconds}}, `
                #Difficulty, `
                #@{Name="Rows";Expression={[int]$_.Rows}}
            }

        
        #write-host $($csv | ft * | Out-String)
        #write-host $("after import $($watch.Elapsed.ToString("ss"))")
<#        
#CHANGE VALUES ONLY IF NEEDED        
        $a = 0
        foreach($item in $csv){
            $item.PSObject.Properties | ForEach-Object {
                if($_.Name -eq "WinLose" -and $_.Value -eq "0" -and $_.Value -ne $null){
                    #$_.Value.GetType()
                    $csv[$a].$($_.Name) = "Quit"
                    #$csv[$a].$($_.Value)
                    #write-host $($_.Value.GetType())
                }else{}
            }
            $a = $a + 1
        }
#>       

#GROUP
        #$GroupSummary = $csv | Where-Object{$_.WinLose -like "Win"} | Group-Object -Property User,Difficulty,Rows,TimeInSeconds,Date -NoElement
        $GroupSummary = $csv | Where-Object{$_.WinLose -like "Win"} | Group-Object -Property User,Rows,Bombs,TimeInSeconds,Date -NoElement #9/3
        #$GroupSummary = $csv | Where-Object{$_.WinLose -like "Win"} | Group-Object -Property User,Rows,Difficulty,WinLose,TimeInSeconds,Date -NoElement
        #write-host $("after group $($watch.Elapsed.ToString("ss"))")
        #write-host $($GroupSummary | ft * | Out-String)
#REORG GROUPS
        $renameSummary = $($GroupSummary | 
            Select-Object `
                @{ l="`nName"; e={$_.Name.Split(",")[0]}}, `
                @{ l="`nRows"; e={[int]$_.Name.Split(",")[1]}}, `
                @{ l="`nBombs"; e={[int]$_.Name.Split(",")[2]}}, `
                @{ l="`nSeconds"; e={[double]$_.Name.Split(",")[3]}}, `
                @{ l="`nDate"; e={$($($_.Name.Split(",")[4]).toString().Trim())}}
        )

                #write-host $("after reorg $($watch.Elapsed.ToString("ss"))")
        #write-host $($renameSummary | ft * | Out-String)

#FILTER STATS

            $s = $($renameSummary | Sort @{e="`nRows"; Ascending=$true},@{e="`nBombs"; Ascending=$true}, `nSeconds, @{e="`nDate"; Descending=$true}) #9/4
            
            Try{
                $rr = $($($s | Sort @{e="`nRows"; Ascending=$true} -Unique | %{$_."`nRows" | Out-String}).Trim())
                $bb = $($($s | Sort @{e="`nBombs"; Ascending=$true} -Unique | %{$_."`nBombs" | Out-String}).Trim())
            }catch{}
            $r = $Rows
            #$d = $Difficulty
            $b = $bombs ###########################################################################################################
            $all = [pscustomobject]@()
            
            if($r -eq $null -or $r -eq "" -or $Allstats -eq 1 -or $b -eq "" -or $b -eq $null){
#GET STATS BUTTON              
                forEach($item in $rr){
                    foreach($item2 in $bb){
                        $all += $($s | Where-Object{$($_."`nRows".tostring().trim()) -eq $item.ToString() -and $($_."`nBombs".tostring().trim()) -eq $item2} | Select-Object -first 1)
                    }
                }
                #write-host $("filter all $($watch.Elapsed.ToString("ss"))")
                #write-host $($all | ft * | Out-String)
                #write-host $($all | %{$_."`nBombs".gettype()})
                Return $all
            }else{
#LEADERSHIP BOARD
                $return = $($s | Where-Object{$($_."`nRows".tostring().trim()) -eq $r.ToString() -and $($_."`nBombs".tostring().trim()) -eq $b} | Select-Object `nName,`nSeconds,`nDate  -first 3)
                Try{
                    $len = $($($($return[0] | ft * | Out-String).Trim()).Length)
                }catch{
                    $len = 0
                }
                if($len -eq 0){
                    Return "There are no scores recorded with these settings. Win the round and become the uncontested champ!"
                }else{
                    Return $return
                }
            }
#}
}


Function GetSummary($Difficulty,$Rows,$Allstats){ #USED TO CONVERT STRINGS AS NUMBERS TO INTEGERS

        #write-host "d=$Difficulty, r=$Rows, a=$Allstats"
        #write-host "d=$($Difficulty.gettype()), r=$($Rows.gettype()), a=$($Allstats.gettype())"
#IMPORT CSV AND TYPECAST
        $csv = Import-Csv "$PSScriptroot\Stats\FastestGame.csv" | 
        Select Name, `
        @{Name="Rows";Expression={[int]$_.Rows}}, `
        Difficulty, `
        @{Name="Seconds";Expression={[double]$_.Seconds}},
        Date
        
#FILTER STATS
            $r = $Rows
            $d = $Difficulty
            $all = [pscustomobject]@()
            if($r -eq $null -or $r -eq "" -or $d -eq $null -or $d -eq "" -or $Allstats -eq 1){
                forEach($item in 3..15){
                    foreach($item2 in "Easy","Medium","Hard"){
                        $all += $($csv | Where-Object{$($_.Rows.tostring().trim()) -eq $item.ToString() -and $($_.Difficulty.tostring().trim()) -eq $item2})
                    }
                }
                Return $all
            }else{
                $return = $($csv | Where-Object{$($_.Rows.tostring().trim() -eq $r.ToString()) -and $($_.Difficulty.tostring().trim() -eq $d)} | ft * | Out-String)
                if($return -eq "" -or $return -eq $null -or $return.ToString().Trim().Length -eq 0){
                    Return "No Stats Available For This Game."
                }else{
                    Return $return
                }
            }
}


Function CreateBombImage($b, $f){
    Add-Type -AssemblyName System.Drawing
    For($i = 0;$i -le 8;$i++){
        $name = [string]$i+"Bomb"
        $filename = "$PSScriptRoot\Image\$name.png"
        $bmp = new-object System.Drawing.Bitmap 58,58 
        $font = new-object System.Drawing.Font Consolas,36 
        $brushBg = [System.Drawing.Brushes]::$b
        $brushFg = [System.Drawing.Brushes]::$f
        $graphics = [System.Drawing.Graphics]::FromImage($bmp) 
        $graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
        $graphics.DrawString($i,$font,$brushFg,20,-8) 
        $graphics.Dispose()
        Try{
            $bmp.Save($filename)
        }Catch{
            #$bmp.Save($filename)
        }

        $name = [string]$i+"Bombsmall"
        $filename = "$PSScriptRoot\Image\$name.png"
        $bmp = new-object System.Drawing.Bitmap 48,48 
        $font = new-object System.Drawing.Font Consolas,24 
        $brushBg = [System.Drawing.Brushes]::$b
        $brushFg = [System.Drawing.Brushes]::$f
        $graphics = [System.Drawing.Graphics]::FromImage($bmp) 
        $graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
        $graphics.DrawString($i,$font,$brushFg,20,-3) 
        $graphics.Dispose()
        Try{
            $bmp.Save($filename)
        }Catch{
            #$bmp.Save($filename)
        }

        $name = [string]$i+"Bomblarge"
        $filename = "$PSScriptRoot\Image\$name.png"
        $bmp = new-object System.Drawing.Bitmap 75,75 
        $font = new-object System.Drawing.Font Consolas,36 
        $brushBg = [System.Drawing.Brushes]::$b
        $brushFg = [System.Drawing.Brushes]::$f
        $graphics = [System.Drawing.Graphics]::FromImage($bmp) 
        $graphics.FillRectangle($brushBg,0,0,$bmp.Width,$bmp.Height) 
        $graphics.DrawString($i,$font,$brushFg,35,-8) #Left,Top
        $graphics.Dispose()
        Try{
            $bmp.Save($filename)
        }Catch{
            #$bmp.Save($filename)
        }
    }
}


Function GetBombImage($getBombImg,$imgSize){
    if($getBombImg -eq "" -or $getBombImg -eq $null){$getBombImg = "0"}
    $intGetBombImg = $getBombImg
    if($intGetBombImg -eq ""){$intGetBombImg = "0"}

    if($imgSize -eq 2){
        switch ($intGetBombImg) {
           "0" {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\0Bomb.png")}
           1 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\1Bomb.png")}
           2 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\2Bomb.png")}
           3 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\3Bomb.png")}
           4 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\4Bomb.png")}
           5 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\5Bomb.png")}
           6 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\6Bomb.png")}
           7 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\7Bomb.png")}
           8 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\8Bomb.png")}
        }   
    }elseif($imgSize -eq 1){
        switch ($intGetBombImg) {
           "0" {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\0Bombsmall.png")}
           1 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\1Bombsmall.png")}
           2 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\2Bombsmall.png")}
           3 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\3Bombsmall.png")}
           4 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\4Bombsmall.png")}
           5 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\5Bombsmall.png")}
           6 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\6Bombsmall.png")}
           7 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\7Bombsmall.png")}
           8 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\8Bombsmall.png")}
        }   
    }elseif($imgSize -eq 3){
        switch ($intGetBombImg) {
           "0" {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\0Bomblarge.png")}
           1 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\1Bomblarge.png")}
           2 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\2Bomblarge.png")}
           3 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\3Bomblarge.png")}
           4 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\4Bomblarge.png")}
           5 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\5Bomblarge.png")}
           6 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\6Bomblarge.png")}
           7 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\7Bomblarge.png")}
           8 {$script:bombImg = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\8Bomblarge.png")}
        }       
    }else{}
}


Function GetBombCount($array,$button){
    if($this -ne $null){
        do{
            $buttonArray | %{if($_.ButtonText -eq $this.Text){<#$this.Text = $_.BombCount;if($this.Text -eq ""){$this.Text = "0"}#>;GetBombImage $_.BombCount $_.imgSize;break}}
        }while($false)
    }else{
        do{
            $buttonArray | %{if($_.ButtonText -eq $button.Text){<#$button.Text = $_.BombCount;if($this.Text -eq ""){$this.Text = "0"}#>;GetBombImage $_.BombCount $_.imgSize;break}}
        }while($false)
    }
}


Function BombCount5($button){
#GET BOMB COUNT
:outer2    ForEach($adjbutton in $($iter.AdjacentButtons)){
:inner2        ForEach($iter in $buttonArray){
                if($($adjbutton.Row) -eq $($iter.Row) -and $($adjbutton.Column) -eq $($iter.Column)){
                    if($($iter.Bomb) -eq 1){
                        $bombCount = $bombCount + 1
                        continue :outer2
                    }
                }
              }
          }
    Return $BombCount
}
 

Function GetAdjacentButtons($r,$c,$maxrows){
    $maxrows = $maxrows - 1
    $adjacentbuttonarray = @()
:outer  for($rr = $($r-1);$rr -le $r+1;$rr++){
             if($rr -lt 0){
                 do{
                      $rr++
                 }while($rr -lt 0);
             }
             if($rr -gt $maxrows){
                break
             }

:inner       for($cc = $($c-1);$cc -le $c+1;$cc++){
                 if($cc -lt 0){
                    do{
                        $cc++
                    }while($cc -lt 0);
                 }

                if($cc -gt $maxrows){
                    break :inner
                }


                if($rr -ne $r -or $cc -ne $c){
                    $adjacentbuttonarray += [PScustomobject]@{Row=$rr;Column=$cc;}
                }
             }
         }
         Return $adjacentbuttonarray
}
 

Function Media3{
    param(
        [Parameter(Mandatory=$True, Position=1)]
        [string]$soundPath,

        [Parameter(Mandatory=$True, Position=2)]
        [string[]]$winlose,

        [Parameter(Mandatory=$True, Position=3)]
        [string]$mute
    )
    $winlose = $winlose | Sort-Object {Get-Random}
#TEST IF MUSIC ALREADY RUNNING
    Try{
        $null = $(get-process -id $script:musicID -ErrorAction Stop)

#IF MUSICID NOT VALID, THAN MUSIC NOT RUNNING.
    }catch{
        #write-host $("errored out $($script:musicID), $mute")
        if($mute -eq $false){
            $inlineSound = [scriptblock]::Create("import-module -Name $soundPath")
            @(start-job -InitializationScript $inlineSound -ScriptBlock {Sound $args[0]} -ArgumentList $winlose | Receive-Job) # -Wait -AutoRemoveJob)
            [int]$script:musicID = $(Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID).ProcessID
        }
    }
}


Workflow Media{
    param(
        [Parameter(Mandatory=$True, Position=1)]
        [string]$soundPath,

        [Parameter(Mandatory=$True, Position=2)]
        [string]$imagePath,

        [Parameter(Mandatory=$True, Position=3)]
        [string]$winlose,

        [Parameter(Mandatory=$True, Position=4)]
        [string]$mute
    )

        $inlineImage = [scriptblock]::Create("import-module -Name $imagePath")
        $inlineSound = [scriptblock]::Create("import-module -Name $soundPath")
    if($mute -eq $false){
        parallel{
            @(start-job -InitializationScript $inlineImage -ScriptBlock {Image $args[0]} -ArgumentList $winlose | Receive-Job) # -Wait -AutoRemoveJob)
            @(start-job -InitializationScript $inlineSound -ScriptBlock {Sound $args[0]} -ArgumentList $winlose | Receive-Job) # -Wait -AutoRemoveJob)
        }
    }else{
        parallel{
            @(start-job -InitializationScript $inlineImage -ScriptBlock {Image $args[0]} -ArgumentList $winlose | Receive-Job) # -Wait -AutoRemoveJob)
            #@(start-job -InitializationScript $inlineSound -ScriptBlock {Sound $args[0]} -ArgumentList $winlose | Receive-Job) # -Wait -AutoRemoveJob)
        }
    }
}


#########################################################################################################
###USER FORM######USER FORM######USER FORM######USER FORM######USER FORM######USER FORM######USER FORM###
#########################################################################################################

Function LoadUser{
    param(
        [Parameter(Mandatory=$false)][string]$user,
        [Parameter(Mandatory=$false)][int]$difficulty,
        [Parameter(Mandatory=$false)][int]$numRows,
        [Parameter(Mandatory=$false)][Boolean]$mute
    )
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Windows.Forms

#CREATE FORM
    $UserForm = New-Object System.Windows.Forms.Form
    $UserForm.Text = "MINESWEEPER $($user.ToUpper())"
    $UserForm.Height = 380
    $UserForm.Width = 370
    $UserForm.StartPosition = "CenterScreen"
    $UserForm.FormBorderStyle = 4
    $UserForm.BackgroundImage = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\imgButtonFuzzy.png") #Camo or button theme
    $UserForm.BackgroundImageLayout = "Stretch" # None, Tile, Center, Stretch, Zoom
    $UserForm.Name = "UserForm"

#ANCHOR TOP LEFT
    $AnchorTopLeft = New-Object System.Windows.Forms.Label
    $AnchorTopLeft.Size = New-Object System.Drawing.Size(1,1) #W,H
    $AnchorTopLeft.Left = 5
    $AnchorTopLeft.Top = 10
    $AnchorTopLeft.Text = ""
    $AnchorTopLeft.BackColor = "Transparent" #Transparent
    $UserForm.Controls.Add($AnchorTopLeft)
    $AnchorTopLeft.Name = "AnchorTopLeft"

<#
#LABEL FORM
    $LabelForm = New-Object System.Windows.Forms.Label
    $LabelForm.Size = New-Object System.Drawing.Size(400,40) #W,H
    $LabelForm.Left = 80
    $LabelForm.Top = 10
    $LabelForm.Text = "Minesweeper"
    $LabelForm.Font = New-Object System.Drawing.Font("Arial",23,[System.Drawing.FontStyle]::Bold)
    $LabelForm.forecolor = "Black"
    $LabelForm.BackColor = "Transparent" #Transparent
    #$UserForm.Controls.Add($LabelForm)
    $LabelForm.Name = "LabelUserForm"
#>

#QUICK START BUTTON
    $QuickStartbutton = New-Object System.Windows.Forms.Button
    $QuickStartbutton.Size = New-Object System.Drawing.Size(200,60) #W,H
    $QuickStartbutton.Left = 80
    $QuickStartbutton.Top = 10
    #$QuickStartbutton.Left = $($($UserForm.Width - $QuickStartbutton.Width)/2 - 8)
    #$QuickStartbutton.Top = $($AnchorTopLeft.Bottom + 39)
    $QuickStartbutton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $QuickStartbutton.Text = $("Play New Game")
    $QuickStartbutton.Name = "QuickStartbutton"
    $UserForm.Controls.Add($QuickStartbutton)
    $QuickStartbutton.Add_Click({
        $script:user = $UserListBox.SelectedItem
        $script:QuickStart = 1;
        $UserForm.Dispose()
        
    })

#Random Game Checkbox
    $RandomGameCheckbox = New-Object System.Windows.Forms.Checkbox 
    $RandomGameCheckbox.AutoSize = $false
    $RandomGameCheckbox.Size = New-Object System.Drawing.Size(70,30)#W,H
    $RandomGameCheckbox.Top = $($QuickStartbutton.Bottom + 10)
    $RandomGameCheckbox.Left = $($($UserForm.Width - $RandomGameCheckbox.Width)/2 - 8)
    $RandomGameCheckbox.Text = "Random Game?"
    $RandomGameCheckbox.Name = "RandomGameCheckbox"
    $RandomGameCheckbox.forecolor = "Black"
    $RandomGameCheckbox.TabIndex = 1
    $UserForm.Controls.Add($RandomGameCheckbox)
    $RandomGameCheckbox.Checked = $false

#LABEL USER LISTBOX
    $LabelUser = New-Object System.Windows.Forms.Label
    $LabelUser.AutoSize = $True
    $LabelUser.Left = $($AnchorTopLeft.Left + 20)
    $LabelUser.Top = $($QuickStartbutton.Bottom + 45)
    $LabelUser.Text = "Select User"
    $LabelUser.Font = New-Object System.Drawing.Font("Arial",13,[System.Drawing.FontStyle]::Bold)
    $LabelUser.forecolor = "Black"
    $LabelUser.BackColor = "Transparent"
    $UserForm.Controls.Add($LabelUser)
    $LabelUser.Name = "LabelUser"

#USER LISTBOX
    $UserListBox = New-Object System.Windows.Forms.ListBox
    $UserListBox.Size = New-Object System.Drawing.Size(120,100) #W,H
    $UserListBox.AutoSize = $False
    $UserListBox.Top = $($LabelUser.Bottom)
    $UserListBox.Left = $($LabelUser.Left - 6)
    $UserListBox.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Regular)
    $UserListBox.Text = "Select User"
    $UserListBox.Name = "UserListBox"
    $UserListBox.forecolor = "Black"
    #$UserListBox.BackColor = "Olive"
    $UserListBox.BorderStyle = 1
    #$UserListBox.HorizontalScrollbar = $True
    $UserListBox.ScrollAlwaysVisible = $True
    #$UserListBox.MultiColumn = $True
    $UserListBox.IntegralHeight = $True
    #$UserListBox.SetSelected(0,$true)
    $UserForm.Controls.Add($UserListBox)
    #import-module "$psscriptroot\Config\GetGV.psm1" -Function GetGV #9/44
    #import-module "$psscriptroot\Config\ResetGV.psm1" -Function ResetGV #9/44
    $users = GetGV * "User"
    if($users -eq $null -or $users -eq ""){ResetGV;$users = GetGV * "User"}
    $users | %{[void] $UserListBox.Items.Add($_)}
    if($script:user -eq "" -or $script:user -eq $null){
        $UserListBox.SelectedIndex = 0
        $script:user = $UserListBox.SelectedItem
        $UserForm.Text = "MINESWEEPER $($($UserListBox.SelectedItem).ToUpper())"
    }else{
        $UserListBox.SelectedItem = $script:user
        $UserForm.Text = "MINESWEEPER - $($script:user.ToUpper())"
    }

#SELECT USER BUTTON
    $SelectUserButton = New-Object System.Windows.Forms.Button
    $SelectUserButton.Size = New-Object System.Drawing.Size($($UserListBox.Width),50) #W,H
    $SelectUserButton.AutoSize = $False
    $SelectUserButton.Left = $($UserListBox.Left)
    $SelectUserButton.Top = $($UserListBox.Bottom)
    $SelectUserButton.Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold)
    #$SelectUserButton.BackColor = "Light Green"
    $SelectUserButton.Text = "Select User"
    $SelectUserButton.Name = "SelectUserButton"
    $UserForm.Controls.Add($SelectUserButton)
    $SelectUserButton.Add_Click({
        if($UserListBox.SelectedItem -eq "" -or $UserListBox.SelectedItem -eq $null){
            $script:user = "Player1"
        }else{
            $script:user = $UserListBox.SelectedItem
        }
        #import-module "$psscriptroot\Config\GetGV.psm1" -Function GetGV #9/44
        #write-host "468 $script:user = $UserListBox.SelectedItem"
        $script:difficulty = GetGV $script:user "Difficulty"
        $script:numRows = GetGV $script:user "Rows"
        $script:mute = GetGV $script:user "Mute"
        #write-host "726 $script:user $script:difficulty, $script:numRows, $script:mute"
        $UserForm.Dispose()
     })

#REMOVE USER BUTTON
    $RemoveUserButton = New-Object System.Windows.Forms.Button
    $RemoveUserButton.AutoSize = $True
    $RemoveUserButton.Left = $($($SelectUserButton.Width - $RemoveUserButton.Width)/2 + 20)
    $RemoveUserButton.Top = $($SelectUserButton.Bottom + 7)
    $RemoveUserButton.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Bold)
    #$RemoveUserButton.BackColor = "Light Green"
    $RemoveUserButton.Text = "Remove"
    $RemoveUserButton.Name = "RemoveUserButton"
    $UserForm.Controls.Add($RemoveUserButton)
    $RemoveUserButton.Add_Click({
        $oReturn=[System.Windows.Forms.MessageBox]::Show("Are you sure you want to remove $($UserListBox.SelectedItem)?","WARNING",[System.Windows.Forms.MessageBoxButtons]::YesNo) 
        switch ($oReturn){
            "Yes" {
                    $UserForm.Dispose()
                    #import-module "$psscriptroot\Config\AddRemoveGV.psm1" -Function AddRemoveGV #9/44
                    AddRemoveGV "Remove" $UserListBox.SelectedItem "8" "1" "false"
                    $script:user = "Player1"
                    $script:difficulty = 2
                    $script:numRows = 6
                    $script:mute = $false
                    LoadUser $script:user $script:difficulty $script:numRows $script:mute
                  } 
            "No"  {} 
        }
    })

#LABEL CREATE NEW USER
    $CreateUserLabel = New-Object System.Windows.Forms.Label
    $CreateUserLabel.AutoSize = $True
    $CreateUserLabel.Left = $($LabelUser.Right + 40)
    $CreateUserLabel.Top = $($LabelUser.Top)
    $CreateUserLabel.Text = "Create a New User"
    $CreateUserLabel.Name = "CreateUserLabel"
    $CreateUserLabel.Font = New-Object System.Drawing.Font("Arial",13,[System.Drawing.FontStyle]::Bold)
    #$CreateUserLabel.backcolor = "White"
    $CreateUserLabel.forecolor = "Black"
    $CreateUserLabel.BackColor = "Transparent"
    $UserForm.Controls.Add($CreateUserLabel)

#CREATE NEW USER TEXTBOX
    $NewUserTextBox = New-Object System.Windows.Forms.TextBox
    $NewUserTextBox.Size = New-Object System.Drawing.Size(165,20)#W,H
    $NewUserTextBox.Top = $CreateUserLabel.Bottom
    $NewUserTextBox.Left = $($CreateUserLabel.Left - 7)
    $NewUserTextBox.Text = "Enter Your Name Here"
    $NewUserTextBox.Name = "NewUserTextBox"
    $NewUserTextBox.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Regular)
    $NewUserTextBox.Add_Gotfocus( { $this.SelectAll(); $this.Focus() })
    $NewUserTextBox.Add_Click( { $this.SelectAll(); $this.Focus() })
    $UserForm.Controls.Add($NewUserTextBox)

#ADD NEW USER BUTTON
    $AddUserbutton = New-Object System.Windows.Forms.Button
    $AddUserbutton.Size = New-Object System.Drawing.Size(120,50) #W,H
    $AddUserbutton.AutoSize = $False
    $AddUserbutton.Left = $($NewUserTextBox.Left + 23)
    $AddUserbutton.Top = $($NewUserTextBox.Bottom + 10)
    $AddUserbutton.Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold)
    $AddUserbutton.Text = "Create User"
    $AddUserbutton.Name = "AddUserbutton"
    $UserForm.Controls.Add($AddUserbutton)
    $AddUserbutton.Add_Click({
        $script:user = $NewUserTextBox.Text
        #import-module "$psscriptroot\Config\AddRemoveGV.psm1" -Function AddRemoveGV #9/44
        AddRemoveGV "Add" $script:user 1 6 $false
        #import-module "$psscriptroot\Config\GetGV.psm1" -Function GetGV #9/44
        $user = $script:user
        $script:difficulty = GetGV $user "Difficulty"
        $script:numRows = GetGV $user "Rows"
        $script:mute = GetGV $user "Mute"
        $UserForm.Dispose()
        LoadUser $script:user $script:difficulty $script:numRows $script:mute
    })

#STATS BUTTON
    $ShowStatsButton = New-Object System.Windows.Forms.Button
    $ShowStatsButton.Size = New-Object System.Drawing.Size(100,50) #W,H
    $ShowStatsButton.Left = $($SelectUserButton.Left + $SelectUserButton.Width)
    $ShowStatsButton.Top = $($SelectUserButton.Top)
    $ShowStatsButton.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
    $ShowStatsButton.Text = "Show Stats"
    $ShowStatsButton.Name = "ShowStatsButton"
    $UserForm.Controls.Add($ShowStatsButton)
    [void]$ShowStatsButton.Add_Click({
        #<#
        #$watch2 =  [system.diagnostics.stopwatch]::StartNew()
        #$stats = GetStats "Easy" 7 1 #GetStats difficulty rows $(1=all,0=singlestat)
       
        $stats = GetStats "1" "3" 1 #GetStats difficulty rows $(1=all,0=singlestat) #9/3

        write-host $m
        #write-host $("525 after stats $($watch2.Elapsed.ToString("ss"))")
        
        $outgridview = $stats | Select-Object *
        $outgridview2 = @()
        $($outgridview | %{
            $outgridview2 += [pscustomobject]@{Name=$($_."`nName");Rows=$($_."`nRows");Bombs=$($_."`nBombs");Seconds=$($_."`nSeconds");Date=$($_."`nDate")}
        })

        if($stats -ne $null){
            $outgridview2 | Out-GridView
            $outgridview2 | Export-Csv -NoTypeInformation "$PSScriptRoot/Stats/FastestGame.csv"
        }else{        
            $oReturn=[System.Windows.Forms.MessageBox]::Show("There are no top scores to show.","Top Score",[System.Windows.Forms.MessageBoxButtons]::Ok) 
        }
        
        #write-host $("after gridview $($watch2.Elapsed.ToString("ss"))")
        
        
        
        #write-host $("after export $($watch2.Elapsed.ToString("ss"))")
        #>

        <#
        $summm = GetSummary "" "" "0"
        #write-host $summm
        $outgridview = $summm | Select-Object *
        $outgridview2 = @()
        $($outgridview | %{
            $outgridview2 += [pscustomobject]@{Name=$($_.Name);Rows=$($_.Rows);Difficulty=$($_.Difficulty);Seconds=$($_.Seconds);Date=$($_.Date)}
        })
        $outgridview2 | Out-GridView
        #>
    })


#EXIT BUTTON
    $exitbutton = New-Object System.Windows.Forms.Button
    $exitbutton.Size = New-Object System.Drawing.Size(100,50) #W,H
    $exitbutton.Left = $($SelectUserButton.Left + $SelectUserButton.Width + 100)
    $exitbutton.Top = $($SelectUserButton.Top)
    $exitbutton.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
    $exitbutton.Text = "Exit Program"
    $exitbutton.Name = "exitbutton"
    [void]$UserForm.Controls.Add($exitbutton)
    [void]$exitbutton.Add_Click({
        #Kill Duplicate Music
        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
        Try{
            $id.ProcessID | %{Stop-Process -Id $_ -ErrorAction SilentlyContinue}
        }Catch{}
        $script:exit = 1;
        $UserForm.Dispose()
    })

#PLAY MUSIC
    if($script:giveUp -eq 0){
        $script:Replay2 = 0
    }
    media3 $soundPath $musicPlaylist $mute
    
#SHOW DIALOG
    $UserForm.Activate();
    $UserForm.ShowDialog() | Out-Null

#RETURN VALUES
    $script:randomGame = $RandomGameCheckbox.Checked
    $attributes = @($script:user,$script:difficulty,$script:numRows,$script:mute)
    #write-host "611 $script:user,$script:difficulty,$script:numRows,$script:mute`n`n`n"
    Return $attributes
}

#########################################################################################################
###USER FORM######USER FORM######USER FORM######USER FORM######USER FORM######USER FORM######USER FORM###
#########################################################################################################



############################################################################################################
###OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM###
############################################################################################################

Function ParametersForm($user,$difficulty,$numRows,$mute){
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Windows.Forms

#CREATE FORM
    $ParametersForm = New-Object System.Windows.Forms.Form
    $ParametersForm.Text = "MINESWEEPER - $($user.ToUpper())"
    $ParametersForm.Name = "ParametersForm"
    $ParametersForm.Height = 500
    $ParametersForm.Width = 375
    $ParametersForm.StartPosition = "CenterScreen"
    $ParametersForm.BackgroundImage = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\imgButtonFuzzy.png") #Camo or button theme
    $ParametersForm.BackgroundImageLayout = "Tile" # None, Tile, Center, Stretch, Zoom

#LABEL OPTIONS FORM
    $LabelOptions = New-Object System.Windows.Forms.Label
    $LabelOptions.AutoSize = $True
    $LabelOptions.Left = 10
    $LabelOptions.Top = 10
    $LabelOptions.Text = "Options"
    $LabelOptions.Name = "LabelOptions"
    $LabelOptions.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    #$objScoreboard.backcolor = "White"
    $LabelOptions.forecolor = "Black"
    $ParametersForm.Controls.Add($LabelOptions)

#LABEL ROWS
    $LabelRows = New-Object System.Windows.Forms.Label
    $LabelRows.Size = New-Object System.Drawing.Size(190,25) #W,H
    $LabelRows.Left = 10 #$($($ParametersForm.Width/2) - $($LabelRows.Width/2))
    $LabelRows.Top = $($LabelOptions.Bottom + 20)
    $LabelRows.Text = "Number of Rows:"
    $LabelRows.Name = "LabelRows"
    $LabelRows.Font = New-Object System.Drawing.Font("Arial",16,[System.Drawing.FontStyle]::Bold)
    #$objScoreboard.backcolor = "White"
    $LabelRows.forecolor = "Black"
    $ParametersForm.Controls.Add($LabelRows)

#MUTE BOX
    $muteCheckbox = New-Object System.Windows.Forms.Checkbox 
    $muteCheckbox.AutoSize = $false
    $muteCheckbox.Size = New-Object System.Drawing.Size(50,30)#W,H
    $muteCheckbox.Top = $($LabelRows.Top - 30)
    $muteCheckbox.Left = $($LabelRows.Left + $LabelRows.Width + 10 + 30)
    $muteCheckbox.Text = "Mute"
    $muteCheckbox.Name = "muteCheckbox"
    $muteCheckbox.forecolor = "Black"
    $muteCheckbox.TabIndex = 1
    $ParametersForm.Controls.Add($muteCheckbox)
    $muteCheckBox.Checked = $mute

#ROWS
    $rowsListBox = New-Object System.Windows.Forms.ListBox
    $rowsListBox.Size = New-Object System.Drawing.Size(350,60) #W,H
    $rowsListBox.Top = $($LabelRows.Bottom + 5)
    $rowsListBox.Left = $($($ParametersForm.Width - $rowsListBox.Width)/2 - 7)
    $rowsListBox.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $rowsListBox.Text = "Number of Rows"
    $rowsListBox.Name = "rowsListBox"
    $rowsListBox.forecolor = "Black"
    $rowsListBox.BorderStyle = 1
    #$rowsListBox.HorizontalScrollbar = $False
    #$rowsListBox.ScrollAlwaysVisible = $True
    $rowsListBox.MultiColumn = $True
    $rowsListBox.ColumnWidth = 50
    $rowsListBox.IntegralHeight = $True
    [void] $rowsListBox.Items.Add('3')
    [void] $rowsListBox.Items.Add('4')
    [void] $rowsListBox.Items.Add('5')
    [void] $rowsListBox.Items.Add('6')
    [void] $rowsListBox.Items.Add('7')
    [void] $rowsListBox.Items.Add('8')
    [void] $rowsListBox.Items.Add('9')
    [void] $rowsListBox.Items.Add('10')
    [void] $rowsListBox.Items.Add('11')
    [void] $rowsListBox.Items.Add('12')
    [void] $rowsListBox.Items.Add('13')
    [void] $rowsListBox.Items.Add('14')
    [void] $rowsListBox.Items.Add('15')
    $minValue = [int]($rowsListBox.Items[0])
    $rowsListBox.SetSelected($([int]$numRows - [int]$minValue),$true)
    $ParametersForm.Controls.Add($rowsListBox)

#ANCHOR CENTER
    $AnchorCenter = New-Object System.Windows.Forms.Label
    $AnchorCenter.Size = New-Object System.Drawing.Size(1,1) #W,H
    $AnchorCenter.Left = $($ParametersForm.Width - $($ParametersForm.Width/2 + $MyGroupBox.Width/2))
    $AnchorCenter.Top = $($rowsListBox.Bottom + 20)
    $AnchorCenter.Text = ""
    $AnchorCenter.BackColor = "Transparent" #Transparent
    $ParametersForm.Controls.Add($AnchorCenter)
    $AnchorCenter.Name = "AnchorCenter"
    
#DIFFICULTY GROUP
    $MyGroupBox = New-Object System.Windows.Forms.GroupBox
    $MyGroupBox.Width = 115
    $MyGroupbox.Height = 130
    $MyGroupBox.Left = 37
    $MyGroupBox.Top = $($rowsListBox.Bottom + 20)
    $MyGroupBox.text = "Select Difficulty"
    $MyGroupBox.Name = "MyGroupBox"
    $MyGroupBox.Font = New-Object System.Drawing.Font("Arial",14,[System.Drawing.FontStyle]::Bold)
    $MyGroupBox.forecolor = "Black"
    
#DIFFICULTY BUTTONS
    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = "10,50" #Col,Row
    $RadioButton1.size = '100,20' #W,H
    $RadioButton1.Checked = if($difficulty -eq 1){$true}else{$false}
    $RadioButton1.Text = "Easy"
    $RadioButton1.Name = "RadioButton1"
    $RadioButton1.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
    $RadioButton1.forecolor = "Black"
 
    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = "10,70" #Col,Row
    $RadioButton2.size = '100,20' #W,H
    $RadioButton2.Checked = if($difficulty -eq 2){$true}else{$false}
    $RadioButton2.Text = "Medium"
    $RadioButton2.Name = "RadioButton2"
    $RadioButton2.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
    $RadioButton2.forecolor = "Black"
 
    $RadioButton3 = New-Object System.Windows.Forms.RadioButton
    $RadioButton3.Location = "10,90" #Col,Row
    $RadioButton3.size = '100,20' #W,H
    $RadioButton3.Checked = if($difficulty -eq 3){$true}else{$false}
    $RadioButton3.Text = "Hard"
    $RadioButton3.Name = "RadioButton3"
    $RadioButton3.Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold)
    $RadioButton3.forecolor = "Black"

#ADD BUTTONS TO RADIOBUTTON
    $MyGroupBox.Controls.AddRange(@($Radiobutton1,$RadioButton2,$RadioButton3))
    $ParametersForm.Controls.Add($MyGroupBox)

#MULTIPLAYER GAME BUTTON
    $multiplayerGameButton = New-Object System.Windows.Forms.Button
    $multiplayerGameButton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $multiplayerGameButton.Left = $(20 + $MyGroupBox.Width + 60)
    $multiplayerGameButton.Top = $($AnchorCenter.Bottom + 10)
    $multiplayerGameButton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $multiplayerGameButton.Text = "Multiplayer"
    $multiplayerGameButton.Name = "multiplayerGameButton"
    $ParametersForm.Controls.Add($multiplayerGameButton)
    $multiplayerGameButton.Enabled = $false
    $multiplayerGameButton.Add_Click({
        #FUNCTION LOAD STATE
        [System.Windows.Forms.MessageBox]::Show("MultiPlayer Game Currently Not Operational.","MINESWEEPER",[System.Windows.Forms.MessageBoxButtons]::OK)
    })

#LOAD SAVED GAME BUTTON
    $loadGameButton = New-Object System.Windows.Forms.Button
    $loadGameButton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $loadGameButton.Left = $(20 + $MyGroupBox.Width + 60)
    $loadGameButton.Top = $($AnchorCenter.Bottom + 80)
    $loadGameButton.Font = New-Object System.Drawing.Font("Arial",16,[System.Drawing.FontStyle]::Bold)
    $loadGameButton.Text = "Load Saved Game"
    $loadGameButton.Name = "loadGameButton"
    $ParametersForm.Controls.Add($loadGameButton)
    $loadGameButton.Enabled = $false
    $loadGameButton.Add_Click({
        #FUNCTION LOAD STATE
        [System.Windows.Forms.MessageBox]::Show("Load State Currently Not Operational.","MINESWEEPER",[System.Windows.Forms.MessageBoxButtons]::OK)
    })

 
#SAVE SETTINGS BUTTON
    $SaveSettingsbutton = New-Object System.Windows.Forms.Button
    $SaveSettingsbutton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $SaveSettingsbutton.Left = 20
    $SaveSettingsbutton.Top = $($AnchorCenter.Bottom + 150)
    $SaveSettingsbutton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $SaveSettingsbutton.Text = "Save Settings"
    $SaveSettingsbutton.Name = "SaveSettingsbutton"
    $ParametersForm.Controls.Add($SaveSettingsbutton)
    $SaveSettingsbutton.Add_Click({
        $oReturn=[System.Windows.Forms.MessageBox]::Show("Are you sure you want to save settings for $($user)?","WARNING",[System.Windows.Forms.MessageBoxButtons]::YesNo) 
        switch ($oReturn){
            "Yes" {
                    #import-module "$psscriptroot\Config\SetGV.psm1" -Function SetGV #9/44
                    if($user -ne $null -and $user -ne ""){
                        if($RadioButton1.Checked -eq $true){
                            $script:difficulty = 1
                        }elseif($RadioButton2.Checked -eq $true){
                            $script:difficulty = 2
                        }elseif($RadioButton3.Checked -eq $true){
                            $script:difficulty = 3
                        }else{
                            $script:difficulty = 1
                        }
                        SetGV $user "Difficulty" $script:difficulty
                        SetGV $user "Rows" $($rowsListBox.SelectedItem/1)
                        SetGV $user "Mute" $muteCheckbox.Checked
                        $script:numRows = $($rowsListBox.SelectedItem/1)
                        $script:mute = $muteCheckbox.Checked
                    }
                  } 
            "No"  {} 
        }
    })

#BACK BUTTON
    $backbutton = New-Object System.Windows.Forms.Button
    $backbutton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $backbutton.Left = 20
    $backbutton.Top =  $($SaveSettingsbutton.Bottom + 10)
    $backbutton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $backbutton.Text = "Switch User"
    $backbutton.Name = "backbutton"
    $ParametersForm.Controls.Add($backbutton)
    $backbutton.Add_Click({
        $script:back = 1;
        $ParametersForm.Dispose();
    })

#PLAY BUTTON
    $playbutton = New-Object System.Windows.Forms.Button
    $playbutton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $playbutton.Left = $($ParametersForm.Right - $($backbutton.Width + 30))
    $playbutton.Top = $SaveSettingsbutton.Top
    $playbutton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $playbutton.Text = "Play New Game"
    $playbutton.Name = "playbutton"
    $ParametersForm.Controls.Add($playbutton)
    $playbutton.Add_Click({
        $ParametersForm.Dispose();
        if($RadioButton1.Checked -eq $true){
            $script:difficulty = 1
        }elseif($RadioButton2.Checked -eq $true){
            $script:difficulty = 2
        }elseif($RadioButton3.Checked -eq $true){
            $script:difficulty = 3
        }else{
            $script:difficulty = 1
        }
        $script:numRows = $($rowsListBox.SelectedItem/1)
        $script:mute = $muteCheckBox.Checked
    })

#EXIT BUTTON
    $exitbutton = New-Object System.Windows.Forms.Button
    $exitbutton.Size = New-Object System.Drawing.Size(150,60) #W,H
    $exitbutton.Left = $($ParametersForm.Right - $($exitbutton.Width + 30))
    $exitbutton.Top = $($SaveSettingsbutton.Bottom + 10)
    $exitbutton.Font = New-Object System.Drawing.Font("Arial",16,[System.Drawing.FontStyle]::Bold)
    $exitbutton.Text = "Exit Program"
    $exitbutton.Name = "exitbutton"
    $ParametersForm.Controls.Add($exitbutton)
    $exitbutton.Add_Click({
        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
        Try{
            $id.ProcessID | %{Stop-Process -Id $_ -ErrorAction SilentlyContinue}
        }Catch{}
        $script:exit = 1;
        $ParametersForm.Dispose();
        })

#RESET REPLAY2
    if($script:giveUp -eq 0){
        $script:replay2 = 0
    }

#SHOW DIALOG
    $ParametersForm.Activate();
    $ParametersForm.ShowDialog() | Out-Null

#RETURN VALUES
    $parameterArray = @($script:user,$script:Difficulty,$script:numRows,$script:mute)
    Return $parameterArray
}

############################################################################################################
###OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM######OPTIONS FORM###
############################################################################################################



#########################################################################################################
###GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM###
#########################################################################################################

Function Form($user,$difficulty,$numRows,$mute){
    Add-Type -AssemblyName System.Drawing
    Add-Type -AssemblyName System.Windows.Forms

    $random = New-Object -TypeName System.Random
    switch ($difficulty) {
        1 {$bomb = Get-Random(1..10)}
        2 {$bomb = ($(Get-Random(1..5)),$(Get-Random(6..10)))}
        3 {$bomb = ($(Get-Random(1..3)),$(Get-Random(4..7)),$(Get-Random(8..10)))}
    }

#RESTRAIN NUMBER OF ROWS
    If($numRows -lt 2 -or $numRows -gt 15){
        write-output "Pick a number from 2 to 15"
        exit
    }elseif($numRows -lt 5){
        $squareHeight=85
        $size = 20
        $imgSize = 3
    }elseif($numRows -lt 10){
        $squareHeight=70
        $size = 18
        $imgSize = 2
    }else{
        $squareHeight=45
        $size = 13
        $imgSize = 1
    }
    
#VARIABLES CREATED
    $script:statsBombs = 0
    $score=0
    $Win = 0
    $script:score=0
    $script:win=0
    $script:replay=0
    $c=0
    $r=0
    $imgButton = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\imgButton.png") #Camo or button theme
    $rightClickImage = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\RightClick.png") #Marker for bombs when right-clicking
    $rightClickImageSmall = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\RightClickSmall.png") #Marker for bombs when right-clicking
    $rightClickImageLarge = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\RightClickLarge.png") #Marker for bombs when right-clicking
    if($user -eq ""){$user = "Player1"}
    switch($imgSize){
        1 {$bombImgPath = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\BombSmall.png")}
        2 {$bombImgPath = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\BombMedium.png")}
        3 {$bombImgPath = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\BombLarge.png")}
    }

    
#CREATE FORM
    $objForm = New-Object System.Windows.Forms.Form
    switch($difficulty){
        1 {$difficulty = "Easy"}
        2 {$difficulty = "Medium"}
        3 {$difficulty = "Hard"}
    }
    $objForm.Text = "MINESWEEPER - $user : $Difficulty : Mute=$mute"
    $objForm.Name = "objForm"
    $objForm.Height = $($($numRows) * $($squareHeight) + 50)
    $objForm.Width = $($($numRows) * $($squareHeight) + 28)
    $objForm.StartPosition = "CenterScreen"
    $objForm.BackgroundImage = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image\imgButtonFuzzy.png") #Camo or button theme
    $objForm.BackgroundImageLayout = "Stretch" # None, Tile, Center, Stretch, Zoom

#SCOREBOARD
    $objScoreboard = New-Object System.Windows.Forms.Label
    $objScoreboard.AutoSize = $true
    $objScoreboard.Location = New-Object System.Drawing.Size(5,15) #Col,Row
    $objScoreboard.Text = "Score: $script:score / $script:win Points"
    $objScoreboard.Name = "objScoreboard"
    $objScoreboard.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    #$objScoreboard.backcolor = "White"
    $objScoreboard.forecolor = "Black"
    #$objForm.Controls.Add($objScoreboard)

#MUTE BOX
    #$muteCheckbox = New-Object System.Windows.Forms.Checkbox 
    #$muteCheckbox.Size = New-Object System.Drawing.Size(50,20)#W,H
    #$muteCheckbox.Location = New-Object System.Drawing.Size($($objScoreboard.Left + $objScoreboard.Width + 30),$($objScoreboard.Bottom)) #Col,Row
    #$muteCheckbox.Top = 20
    #$muteCheckbox.Left = $($objScoreboard.Left + $objScoreboard.Width + 30)
    #$muteCheckbox.Text = "Mute"
    #$muteCheckbox.forecolor = "Black"
    #$muteCheckbox.TabIndex = 1
    #$objForm.Controls.Add($muteCheckbox)
    #If($muteCheckbox.Checked -eq $true){
    #    $mute = 1
    #}else{$mute = 0}

#RESTART BUTTON
    $replayButton = New-Object System.Windows.Forms.Button
    $replayButton.Size = New-Object System.Drawing.Size(120,50) #W,H
    $replayButton.Left = $($($numRows) * $($squareHeight) + 15)
    $replayButton.Top = 5
    $replayButton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $replayButton.Text = "Restart"
    $replayButton.Name = "replayButton"
    $objForm.Controls.Add($replayButton)
    $replayButton.Add_Click({
        if($script:finishedRound -ne 1){$script:winLose = "Quit"}
        $script:replay2 = 1
        $script:replay = 1
        $objForm.Dispose();
    })
    
#GIVE UP BUTTON
    $backButton = New-Object System.Windows.Forms.Button
    $backButton.Size = New-Object System.Drawing.Size(120,50) #W,H
    $backButton.Left = $($replayButton.Left + $replayButton.Width + 5)
    $backButton.Top = $($replayButton.Top)
    $backButton.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    $backButton.Text = "Give Up"
    $backButton.Name = "backButton"
    $objForm.Controls.Add($backButton)
    $backButton.Add_Click({
        $script:giveUp = 1
        if($script:finishedRound -ne 1){$script:winLose = "Quit"}
        $script:replay = 0
        $objForm.Dispose();
    })



#EXIT PROGRAM BUTTON
    $exitButton = New-Object System.Windows.Forms.Button
    $exitButton.Size = New-Object System.Drawing.Size(120,50) #W,H
    $exitButton.Left = $($backButton.Left + $backButton.Width + 5)
    $exitButton.Top = $($replayButton.Top)
    $exitButton.Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold)
    $exitButton.Text = "Exit Program"
    $exitButton.Name = "exitButton"
    $objForm.Controls.Add($exitButton)
    $exitButton.Add_Click({
        #$stopwatch.stop()
        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
        Try{
            $id.ProcessID | %{Stop-Process -Id $_ -ErrorAction SilentlyContinue}
        }Catch{}
        if($script:finishedRound -ne 1){$script:winLose = "Quit";$script:statsBombs = 0}
        $script:replay = 0
        $script:exit = 1
        $objForm.Dispose();
    })

<#
#STATS BOARD LABEL
    $statsboardLabel = New-Object System.Windows.Forms.Label
    $statsboardLabel.Width = 150
    $statsboardLabel.Height = 50
    $statsboardLabel.Top = $($backButton.Bottom + 20)
    $statsboardLabel.AutoSize = $false
    $statsboardLabel.Text = $("TOP SCORE")
    #$statsboardLabel.Text = $text  
    $statsboardLabel.Name = "statsboardLabel"
    $statsboardLabel.Font = New-Object System.Drawing.Font("Arial",18,[System.Drawing.FontStyle]::Bold)
    #$statsboardLabel.TextAlign = "Left"
    #$statsboardLabel.Multiline = $true
    #$statsboardLabel.WordWrap = $true
    #$statsboardLabel.backcolor = "White"
    $statsboardLabel.forecolor = "Black"
    $objForm.Controls.Add($statsboardLabel)
#>

#LEADERBOARD
    $statsboard = New-Object System.Windows.Forms.label
    $statsboard.Width = 330
    $statsboard.Height = 130
    $statsboard.AutoSize = $false
    #write-host $($($(getstats $script:statsBombs $numRows 0) | ft -property "`nName",@{ l="`nSeconds"; e={$_."`nSeconds"};align='Center'},"`nDate" | Out-String).Trim())")
    #write-host $($(getstats $script:statsBombs $numRows 0) | ft -property "`nDate" | Out-String)
    #$statsboard.Text = $text  
    $statsboard.Name = "statsboard"
    $statsboard.Font = New-Object System.Drawing.Font("Courier New",14,[System.Drawing.FontStyle]::Bold)
    #$statsboard.TextAlign = "Left"
    #$statsboard.Multiline = $true
    #$statsboard.WordWrap = $true
    $statsboard.backcolor = "LightSeaGreen"
    $statsboard.forecolor = "Black"
    $objForm.Controls.Add($statsboard)
    #write-host $($statsboard.Text)

#SAVE STATE BUTTON
    $saveStateButton = New-Object System.Windows.Forms.Button
    $saveStateButton.Size = New-Object System.Drawing.Size(120,50) #W,H
    $saveStateButton.Left = $($replayButton.Left)
    $saveStateButton.Font = New-Object System.Drawing.Font("Arial",15,[System.Drawing.FontStyle]::Bold)
    $saveStateButton.Text = "Save State"
    $saveStateButton.Name = "saveStateButton"
    $objForm.Controls.Add($saveStateButton)
    $saveStateButton.Enabled = $false
    $saveStateButton.Add_Click({
        #FUNCTION SAVE STATE
        [System.Windows.Forms.MessageBox]::Show("Save State Currently Not Operational.","MINESWEEPER",[System.Windows.Forms.MessageBoxButtons]::OK)
        
    })


#TEST MEDIA PATH
    If(Test-Path "$PSScriptRoot\Image\Image.psm1"){
        $imagePath = """$PSScriptRoot\Image\Image.psm1"""
    }else{
        write-output "NOT FOUND! $PSScriptRoot\Image\Image.psm1"
    }
    If(Test-Path "$PSScriptRoot\Sound\Modules\Sound\Sound.psm1"){
        $soundPath = """$PSScriptRoot\Sound\Modules\Sound\Sound.psm1"""
    }else{
        write-output "NOT FOUND! $PSScriptRoot\Sound\Modules\Sound\Sound.psm1"
    }

#START LOOP
    $buttonArray = @()
    $r = 0
    While($r -lt $numRows){
        While($c -lt $numRows){
            
#CREATE MAP BUTTONS
            $okbutton = @(0..$c)
            $okbutton[$c] = New-Object System.Windows.Forms.Button
            $okbutton[$c].Location = New-Object System.Drawing.Size($($squareHeight * $c + 6),$($squareHeight * $r + 5)) #W,H
            $okbutton[$c].Size = New-Object System.Drawing.Size($squareHeight,$squareHeight)
            $okbutton[$c].Font = New-Object System.Drawing.Font("Arial",$size,[System.Drawing.FontStyle]::Bold)
            $okbutton[$c].Text = $($($c + 1) + $($numRows * $r))
            $okbutton[$c].TextAlign = "BottomLeft"
            $okbutton[$c].Name = Get-Random(1..10)
            #$okbutton[$c].Image = $imgButton #Camo or whatever the theme is
            if($okbutton[$c].Name -in $bomb){$script:statsBombs = $script:statsBombs + 1}

            $okbutton[$c].ForeColor = 'Black'
            $okbutton[$c].BackColor = 'LightSeaGreen' #LightGray, Gray

#SHOW ALL BOMBS - USED FOR TESTING
            <#
            If($okbutton[$c].Name -in $bomb){
                $okbutton[$c].ForeColor = 'White'
                $okbutton[$c].BackColor = 'Red'            
            }else{
                $okbutton[$c].ForeColor = 'White'
                $okbutton[$c].BackColor = 'DarkGray'           
            }
            #>
  
#WINNING SCORE
            If($okbutton[$c].Name -in $bomb){}else{$win = $($win + [int]$okbutton[$c].Name); $script:win = $($script:win + [int]$okbutton[$c].Name)}

#RIGHT-CLICK ACTION
            $okbutton[$c].Add_MouseDown({
                if($_.Button -eq [System.Windows.Forms.MouseButtons]::Right ){
                    if($imgSize -eq 2){
                        if($this.Image -ne $rightClickImage){
                            $this.Image = $rightClickImage 
                        }else{
                            $this.Image = $null
                        }
                    }elseif($imgSize -eq 1){
                        if($this.Image -ne $rightClickImageSmall){
                            $this.Image = $rightClickImageSmall 
                        }else{
                            $this.Image = $null
                        }
                    }elseif($imgSize -eq 3){
                        if($this.Image -ne $rightClickImageLarge){
                            $this.Image = $rightClickImageLarge 
                        }else{
                            $this.Image = $null
                        }
                    }else{}

                }
            })

            
#CLICK BUTTON ACTION
            $okbutton[$c].Add_Click{

#LOSE ACTION                
                If([int]$this.Name -in $bomb){
                    #[int]$script:time = $($stopwatch.Elapsed.ToString("ss"))
                    #$stopwatch.stop()
                    $timer.stop()
                    $script:finishedRound = 1
                    Write-Host "Bomb";
                    $script:winLose = "Lose"
                    $this.Image = $bombImgPath
                    $this.BackgroundImageLayout = "Stretch"
                    #$this.BackColor = 'Red'
                    $this.ForeColor = 'White'
                    Try{
                        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
                        $id.ProcessID | %{Stop-Process -Id $_} -ErrorAction Stop
                    }catch{}
                    Media $soundPath $imagePath "Bomb" $mute
                    sleep -Seconds 6
                    Try{
                        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
                        $id.ProcessID | %{Stop-Process -Id $_} -ErrorAction Stop
                    }Catch{}
                    media3 $soundPath $musicPlaylist $mute
                    $objForm.Activate();

#REVEAL ALL SQUARES LOSE
                    Foreach($item in $objForm.Controls){
                        if($item.gettype() -like "System.Windows.Forms.Button" -and $item.Name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                            if($item.Name -in $bomb){$script:totalBombs = $script:totalBombs + 1}
                            if($item.Enabled -eq $false){}else{
                                If($item.Name -in $bomb){
                                    $item.Enabled = $false
                                    #$item.Image = $null
                                    #$item.Text = ""
                                    $item.ForeColor = 'White'
                                    #$item.BackColor = 'Red'
                                    $item.Image = $bombImgPath
                                    $item.BackgroundImageLayout = "Stretch"
                                    #$item.Enabled = $true
                                }else{
                                    If($item.name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                                        $item.Enabled = $false
                                    }
                                    #$item.Image = $null
                                    #$item.Text = ""
                                    $item.ForeColor = 'Black'
                                    $item.BackColor = 'LightGray' 
                                }
                            }
                        }
                    }                   
                }     
#WIN ACTION                            
                else{
                    #$global:score=$($global:score + [int]$this.Name)
                    $script:score=$($script:score + [int]$this.Name)
                    $currentscore = $([int]$this.Name)
                    $objScoreboard.Text = "Score: $script:score / $script:win Points"
                    $this.Enabled = $false
                    $this.BackColor = 'LightSeaGreen'
                    $this.ForeColor = 'Gold'
                    GetBombCount $buttonArray, $this
                    $this.Image = $script:bombImg
                    $r = 1
                    if($script:score -ge $script:win){
                        #[int]$script:time = $($stopwatch.Elapsed.ToString("ss"))
                        #$stopwatch.stop()
                        $Timer.Stop();
                        $script:finishedRound = 1
                        Write-Host "Mission Completed!";
                        $script:winLose = "Win"
                        Try{
                            $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
                            $id.ProcessID | %{Stop-Process -Id $_} -ErrorAction Stop
                        }Catch{}
                        Media $soundPath $imagePath "Win" $mute
                        sleep -Seconds 6
                        $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
                        Try{
                            $id.ProcessID | %{Stop-Process -Id $_ -ErrorAction Stop}
                        }Catch{}
                        media3 $soundPath $musicPlaylist $mute
                        $objForm.Activate(); 
                        sleep -milliseconds 1000;
#REVEAL ALL SQUARES WIN
                        Foreach($item in $objForm.Controls){
                            if($item.gettype() -like "System.Windows.Forms.Button" -and $item.Name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                                if($item.Name -in $bomb){$script:totalBombs = $script:totalBombs + 1}
                                if($item.Enabled -eq $false){}else{
                                    If($item.Name -in $bomb){
                                        $item.Enabled = $false
                                        #$item.Image = $null
                                        #$item.Text = ""
                                        $item.ForeColor = 'White'
                                        #$item.BackColor = 'Red'
                                        $item.Image = $bombImgPath
                                        $item.BackgroundImageLayout = "Stretch"
                                        #$item.Enabled = $true
                                    }else{
                                        If($item.name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                                            $item.Enabled = $false
                                        }
                                        #$item.Image = $null
                                        #$item.Text = ""
                                        $item.ForeColor = 'Black'
                                        $item.BackColor = 'LightGray'
                                    }
                                }
                            }
                        } 
                    }  

                }
            }
            $objForm.Controls.Add($okbutton[$c])

#ADD BUTTON ATTRIBUTES TO buttonArray
            $buttonArray += [PScustomobject]@{ButtonName=$okbutton[$c].Name;Row=$r;Column=$c;Bomb=$(if($okbutton[$c].Name -in $bomb){1}else{0});AdjacentButtons="";"BombCount"="0";ButtonText=$okbutton[$c].Text;"imgSize"=$imgSize}

            $c = $c + 1
        }
        $r = $r + 1
        $c=0
    }

#CREATE ADJACENT BUTTON ARRAY
    Foreach($item in $objForm.Controls){
        if($item.gettype() -like "System.Windows.Forms.Button"){
            Foreach($iter in $buttonArray){
                if($iter.ButtonName -eq $item.Name){
                    $iter.AdjacentButtons = GetAdjacentButtons $($iter.Row) $($iter.Column) $numRows #GetAdjacentButtons($r,$c,$maxrows)
                }else{
                }
            } 
        }
    }

#ADD BOMB COUNT
    Foreach($iter in $buttonArray){
            $iter.BombCount = BombCount5 $iter
            if($iter.BombCount -eq ""){$iter.BombCount = "0"}
    }
    $buttoncount = ($objForm.Controls | Where-Object{$_.getType() -like "System.Windows.Forms.Button" -and $_.Name -ne "backButton" -and $_.Name -ne "replayButton" -and $_.Name -ne "exitButton" -and $_.Name -ne "saveStateButton"}).Count

#ADD BOMB IF ONE DOESN'T EXIST
    $j = 1
    $p = 1
    $t = $random.Next($($buttoncount))
    $t = $t + 1

    $addBomb = 0
         #Add-Content "$psscriptroot\Logs\bombs.txt" "938, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win)"
:bomb    Foreach($item in $objForm.Controls){
            if($item.gettype() -like "System.Windows.Forms.Button" -and $item.Name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                #Add-Content "$psscriptroot\Logs\bombs.txt" "940, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name)"
                if($item.Name -in $bomb){
                    #write-host "Contains bomb"
                    break bomb
                }
                if($j -eq $buttoncount -and $item.Name -notin $bomb){
                    #Add-Content "$psscriptroot\Logs\bombs.txt" "946, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name)"
                    Foreach($item2 in $objForm.Controls){
                        if($item2.gettype() -like "System.Windows.Forms.Button" -and $item2.Name -ne "backButton" -and $item2.Name -ne "replayButton" -and $item2.Name -ne "exitButton" -and $item2.Name -ne "saveStateButton"){
                            #Add-Content "$psscriptroot\Logs\bombs.txt" "949, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name), item2=$item2"
                            if($p -eq $t){
                                #Add-Content "$psscriptroot\Logs\bombs.txt" "951, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name)"
                                $item2.Name = $bomb[0]
                                #Add-Content "$psscriptroot\Logs\bombs.txt" "953, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name)"
                                #add BOMB COUNT to array
                                Foreach($iter3 in $buttonArray){
                                    #Add-Content "$psscriptroot\Logs\bombs.txt" "956, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name), iter3.ButtonText=$($iter3.ButtonText), iter3.Buttonname=$($iter3.ButtonName),`niter3=$iter3"
                                    if($iter3.ButtonText -eq $item2.Text){
                                        #Add-Content "$psscriptroot\Logs\bombs.txt" "1049, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name), iter3.ButtonText=$($iter3.ButtonText), iter3.Buttonname=$($iter3.ButtonName), iter3=$iter3"
                                        $iter3.Bomb = 1
                                        $addBomb = 1
                                        $win = $($win - [int]$iter3.ButtonName); $script:win = $($script:win - [int]$iter3.ButtonName)
                                        #write-host "added Bomb"
                                        #Add-Content "$psscriptroot\Logs\bombs.txt" "1054, j=$j, p=$p, t=$t, buttoncount=$buttoncount, bomb=$bomb, win=$win, script:win=$($script:win), item.text=$($item.text), item.name=$($item.Name), item2.text=$($item2.text), item2.name=$($item2.Name), iter3.ButtonText=$($iter3.ButtonText), iter3.Buttonname=$($iter3.ButtonName), iter3=$iter3"
                                        $script:statsBombs = $script:statsBombs + 1
                                        break bomb
                                    }
                                }
                            }
                            $p = $p + 1
                        }
                    }
                } 
                $j = $j + 1
            }
    }

#ADD BOMBCOUNT IF MISSED
    if($addBomb -eq 1){
        Foreach($iter in $buttonArray){
            $iter.BombCount = BombCount5 $iter
            if($iter.BombCount -eq ""){$iter.BombCount = "0"}
        }
    }
    

#REVEAL ONE SQUARE
    $t = $random.Next($buttoncount)
    $t = $t + 1
    $z = 1
    $g = 0
    $x = 0
    $v = 0
    $itemClicked = 0
    Do{
        Foreach($item in $objForm.Controls){
            if($item.gettype() -like "System.Windows.Forms.Button" -and $item.name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                if($z -eq $t -and $item.Name -notin $bomb){
                    if($itemClicked -eq 0){
                        if($item.name -ne "backButton" -and $item.Name -ne "replayButton" -and $item.Name -ne "exitButton" -and $item.Name -ne "saveStateButton"){
                            $item.performclick();
                            $itemClicked = 1;
                            $script:score=$($script:score + [int]$item.Name)
                            $currentscore = $([int]$item.Name)
                            $objScoreboard.Text = "Score: $script:score / $script:win Points"
                            $item.Enabled = $false
                            $item.BackColor = 'LightSeaGreen'
                            $item.ForeColor = 'DarkGray'
                            $v = 1
                            GetBombCount $buttonArray $item
                            $item.Image = $script:bombImg
                            break
                        }
                    }
                }elseif($z -eq $t -and $item.Name -in $bomb){
                    $t = $random.Next($buttoncount)
                    $t = $t + 1
                    $z = 1
                    $g = 1
                    $v = 0
                }
                if($g -ne 1){
                    $z = $z + 1
                }elseif($g -eq 1){
                    $g = 0
                }
            }
        }
    }while($v -eq 0)

#MINIMUM SIZE GAME FORM
    $objForm.minimumSize = New-Object System.Drawing.Size( $( $($numRows) * $($squareHeight) + 20 + $statsboard.Width + 60),$($($numRows) * $($squareHeight)))
    if($objForm.Width -eq $($backButton.Width + $objScoreboard.Width + 10)){
        $replayButton.Left = $($objForm.width - $($replayButton.Width + 20))
    }
 
#CONTROL LOCATIONS
$statsboard.Location = New-Object System.Drawing.Size($($($objForm.Width - $statsboard.Width) - 45),$($backbutton.Bottom + 5)) #Col,Row
#$statsboardLabel.left = $($objForm.Width - $statsboardLabel.Width - 25)
$saveStateButton.Top = $($statsboard.Bottom + 5)

#GetBombCount
    #write-host $statsBombs
    $statsboard.Text = $("LEADERBOARD`n$($($(getstats $script:statsBombs $numRows 0) | ft -property "`nName",@{ l="`nSeconds"; e={$_."`nSeconds"};align='Center'},@{l="`nDate";Expression={$([datetime]$($_."`nDate")).ToString("MM/dd/yyyy").Trim()}} | Out-String).Trim())")

#PLAY MUSIC

    if($script:replay2 -eq 0){
        $run = 1
        do{
            sleep -Milliseconds 250
            Try{
                $id = Get-WmiObject win32_process -filter "Name='powershell.exe' AND ParentProcessId=$PID" | Select ProcessID
                $id.ProcessID | %{Stop-Process -Id $_} -ErrorAction Stop
            }catch{$run = 0}
        }while($run -eq 1)
    }

    #write-host "$script:soundPath $script:musicPlaylist $script:mute"
    Media3 $script:soundPath $script:musicPlaylist $script:mute

#SHOW GAMEFORM    
    $objForm.Topmost = $True
    $objForm.Add_Shown({$objForm.Activate()})
    #$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
    $Timer = New-Object System.Windows.Forms.Timer
    $Timer.Interval = 100 #9/4
    $Script:timerCount = 0
    $Timer.Add_Tick({Timer_Tick})
    $Timer.Start()
    [void] $objForm.Showdialog()
    $backButton.Enabled = $true
    $timer.dispose()
    #write-host $("timercount=$timerCount`nscript:timercount=$script:timerCount")
#WRITE STATS
    if($finishedRound -eq 1 -or $script:winLose -eq "Quit" -or $script:replay -eq 1){Stats}
    #write-host $($script:replay)
}

#########################################################################################################
###GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM######GAME FORM###
#########################################################################################################



############################################################################################################
###SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT###
############################################################################################################

Add-Type -AssemblyName System.Drawing
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
cls
Remove-Job -Name * -Force
$c=$null
$r=$null
$score=0
$currentScore=0
$FormatEnumerationLimit = -1
$random = New-Object -TypeName System.Random
$difficulty = 2
$numRows = 6
$exit = 0
$win=0
$mute=$false
$QuickStart = 0
$user = "Player1"
$back = 0
$finishedGame = 0
$param = @()
$userSettings = @()
#$time = 0
$stats = @()
$winLose = ""
$totalBombs = 0
$statsBombs = 0
$careerStats = @{}
$finishedRound = 0
$timerCount = 0
$replay = 0
$imgSize = 0
$randomGame = $false
$soundPath = """$PSScriptRoot\Sound\Modules\Sound\Sound.psm1"""
[int]$musicID = 1
$musicPlaylist = $("Yankee", "Ulitmate", "Surrounded" | Sort-Object {Get-Random})
$replay2 = 0
$giveUp = 0


#ONLY NEEDED FOR CHANGING BACKGROUND BOMB NUMBER IMAGE COLOR SCHEME
<#
$b = "White" #background
$f = "DarkSlateGray" #Number Color
CreateBombImage $b $f
#>

#IMPORT MODULES
    import-module "$psscriptroot\Config\GetGV.psm1" -Function GetGV #9/44
    import-module "$psscriptroot\Config\ResetGV.psm1" -Function ResetGV #9/44
    import-module "$psscriptroot\Config\AddRemoveGV.psm1" -Function AddRemoveGV #9/44
    import-module "$psscriptroot\Config\SetGV.psm1" -Function SetGV #9/44

:loop do{

#USERFORM CALL    
    if($finishedGame -eq 0 -or $finishedGame -eq $null){
        #write-host "$user $difficulty $numRows $mute"
        $null = $userSettings = LoadUser $user $difficulty $numRows $mute
    }

    $finishedGame = 0
    if($exit -eq 1){exit}
#SETTINGSFORM CALL
    if($QuickStart -eq 0 -or $QuickStart -eq $null){
        if($script:param -ne "" -and $script:param -ne $null){$userSettings = $script:param}
        #$script:param = ParametersForm $userSettings[0] $userSettings[1] $userSettings[2] $userSettings[3]
        $script:param = ParametersForm $user $difficulty $numRows $mute
        if($exit -eq 1){exit}
        if($back -eq 1){$script:back = 0;$back=0;if($script:param -ne "" -or $script:param -ne $null){$script:param = $null};continue loop}
        $mute = $param[3]
    }else{
#QUICK START GAME
        $user = $user
        if($randomGame -eq $false){
            $difficulty = GetGV $user "Difficulty"
            $numRows = GetGV $user "Rows"
            $mute = GetGV $user "Mute"
        }elseif($randomGame -eq $true){
            $Difficulty = $random.Next(1,4);
            $numRows = $random.Next(3,16);
            $mute=$false
        }else{}
    }

#GAMEFORM CALL
Do{
    Form $user $Difficulty $numRows $mute
}While($replay -eq 1)

#REVEAL SCORE
    #if($finishedRound -eq 1){write-host "Score: $score out of $win Points`n"}

#CLEAR VARIABLES
    
    $c=$null
    $r=$null
    $score=$null
    $win=$null
    $QuickStart = 0
    $back = 0
    $finishedGame = 1
    $winLose = ""
    $totalBombs = 0
    $statsBombs = 0
    $stats = ""
    $replay = 0
    $statsBombs = 0
}while($exit -eq 0)
############################################################################################################
###SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT######SCRIPT###
############################################################################################################