<#
Title: System Process Commands
Author: Jamie Giannini

Tasks:
[X] Print to the terminal screen all active processes ordered by highest CPU time consumption at the top  
[X] Print to the terminal screen all active processes ordered by highest Process Identification Number at the top
[X] Print to the terminal screen the top five active processes ordered by highest Working Set at the top 
[X] Start the process Internet Explorer and have it open https://owasp.org/www-project-top-ten/
[X] Start the process Internet Explorer ten times using a for loop. Have each instance open https://owasp.org/www-project-top-ten/ 
[X] Close all Internet Explorer windows
[X] Kill a process by its Process Identification Number. Choose a process whose termination won't destablize the system, such as Internet Explorer or MS Edge 
#>

$start = $true
## All active processes ordered by highest CPU time consumption ##
function sort_cpu(){
Get-Process | Sort CPU -Descending | Format-Table # I needed to add this to make sure I don't lose column titles on subsequent loops
echo "Success!"
}

## All active processes ordered by highest PID ##
function sort_id(){
Get-Process | Sort Id -Descending | Format-Table
echo "Success!"
}

## All active processes ordered by highest Working Set ##
function sort_ws(){
Get-Process | Sort WS -Descending | Format-Table
echo "Success!"
}

## Start Internet Explorer and open a specific webpage
function run_ex(){
[System.Diagnostics.Process]::Start("iexplore","https://owasp.org/www-project-top-ten/")
echo "Success!"
}

## Start Internet Explorer process 10 times using a for loop, open a specific webpage for each instance ##
function run_ex_fun($ex_times){
for ($num = 0; $num -lt $ex_times;  $num++){
[System.Diagnostics.Process]::Start("iexplore","https://owasp.org/www-project-top-ten/")
}
echo "Success!"
}

## Close all Internet Explorer windows
function close_ex(){
Stop-Process -Name iexplore
echo "Success!"
}

## Close one window at a time ##
#Get-Process iexplore | ForEach-Object{$_.CloseMainWindow() | Out-Null} | stop-process -force

#Kill a process by its PID
function close_id($id_value){
Stop-Process -Id $id_value
echo "Success!"
}

## Sort process list by name ##
function process_lookup($name){
Get-Process -Name $name | Format-Table
}

DO {
echo ""
echo "-------------------------------------------------------------"
echo "Please enter a number for the task you would like to execute:"
echo "(1) View active processes by highest CPU consumption"
echo "(2) View active processes by highest ID"
echo "(3) View active processes by highest Working Set"
echo "(4) View active processes by name"
echo "(5) Open Internet Explorer"
echo "(6) Open Internet Explorer many times"
echo "(7) Close Internet Explorer"
echo "(8) Close a process by ID"
echo "(E) Exit program"
echo "-------------------------------------------------------------"
echo ""
$user_input = Read-Host 

if($user_input -eq 1){
sort_cpu
}
elseif($user_input -eq 2){
sort_id
}
elseif($user_input -eq 3){
sort_ws
}
elseif($user_input -eq 4){
echo "Please enter a process name:"
$input_name = Read-Host
process_lookup($input_name)
}
elseif($user_input -eq 5){
run_ex
}
elseif($user_input -eq 6){
echo "How many windows should I open?"
$ex_times = Read-Host
     
run_ex_fun($ex_times)
}
elseif($user_input -eq 7){
close_ex
}
elseif($user_input -eq 8){
echo "Please enter an ID:"
$input_id = Read-Host
close_id($input_id)
}
elseif($user_input -eq "E" -or $user_input -eq "e"){
$start = $false
}
else{
echo "Check input"
}
} While ($start)







