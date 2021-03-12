#Powershell script to compile and run c and c++ programs.

$input = $args[0]

if ($input -eq $null) {
	Write-Host "Enter the file name as arguement"
	exit
}

if (($input -like "*.cpp") -or ($input -like "*.c")) {        	
	if (Test-Path a.exe) {
		Remove-Item a.exe
	}
	g++ $input 	#using g++ for compiling both c and c++ programs
	if (Test-Path a.exe) {
		./a.exe
	}
	else {
		exit
	}
}
elseif ($input -like "*.java") {
	$name_array = $input.Split(".")
	$class_name = $name_array[0]
	$dir_name = "_crun_java_$class_name"
 		
	if (Test-Path $dir_name) {
		Remove-Item $dir_name -Recurse
	}
		
	mkdir $dir_name > $null
	Copy-Item $input $dir_name
	Set-Location $dir_name
	
	javac $input

	java $class_name

	Set-Location ..
	exit
}
else {
	Write-Host "Invalid filename with extension"
	exit
}	
