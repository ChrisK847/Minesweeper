Function Image([string]$imgLoad){
    [System.Windows.Forms.Application]::EnableVisualStyles();
    Add-Type -AssemblyName System.Drawing
    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
    $ParentPath = (get-item $PSScriptRoot).parent.FullName
    $Path = (get-item $PSScriptRoot).FullName
    switch ($imgLoad){
        Bomb {$file = (get-item "$Path\Explosion.png")}
        Win  {$file = (get-item "$Path\Win.png")}
        #n1   {$file = (get-item "")}
        #n2   {$file = (get-item "")}
	default {
                $content = "@
                $(Get-Date);
                $imgLoad;
@"
                $content | Out-file "$ParentPath\Logs\ImageSwitch.txt";
        }
    }
   
    $img = [System.Drawing.Image]::Fromfile($file);
    $form = new-object Windows.Forms.Form
    #$form.ControlBox = $false # new as of 11/3/2021
    $form.FormBorderStyle = "None" #System.Windows.Forms.FormBorderStyle.None; # new as of 11/3/2021
    #$form.Text.Empty;
    $form.MainMenuStrip
    $form.Width = $($img.Size.Width);
    $form.Height = $($img.Size.Height);
    $form.StartPosition = "CenterScreen"
    $form.Topmost = $True
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width =  $($img.Size.Width);
    $pictureBox.Height =  $($img.Size.Height);
    $pictureBox.Image = $img;
    $form.controls.add($pictureBox)
    $form.Add_Shown({ $form.Activate() })
    if($imgLoad -eq "Bomb"){sleep -milliseconds 850}
    $form.Activate();
    Start-Sleep -Milliseconds 150
    $form.Showdialog();
}
Export-ModuleMember -Function Image
