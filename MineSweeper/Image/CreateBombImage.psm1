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
        $bmp.Save($filename)
        #Invoke-Item $filename
    }
}
Export-ModuleMember -Function CreateBombImage