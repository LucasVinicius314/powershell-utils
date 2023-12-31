Add-Type -AssemblyName System.windows.forms

$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$result = $folderBrowser.ShowDialog()

if ($result -eq "OK") {
  $folderPath = $folderBrowser.SelectedPath

  $files = Get-ChildItem -Path $folderPath -Filter *.mp4

  foreach ($file in $files) {
    $fullName = $file.FullName
    $extension = $file.Extension

    $fullNameWithoutExtension = $fullName.Substring(0, $fullName.Length - $extension.Length)

    $outputName = "$fullNameWithoutExtension-compressed$extension"

    $expression = "ffmpeg -i ""$fullName"" -vcodec libx264 -vf scale=300:-2 -crf 30 ""$outputName"""

    Invoke-Expression $expression
  }
}
