﻿Function Image([string]$imgLoad){
    [System.Windows.Forms.Application]::EnableVisualStyles();
    Add-Type -AssemblyName System.Drawing
    
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
    $form.Text = ""
    $form.MainMenuStrip
    $form.Width = $($img.Size.Width + 10);
    $form.Height = $($img.Size.Height + 39);
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