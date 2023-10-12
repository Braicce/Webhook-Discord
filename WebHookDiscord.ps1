
#Defina a URL do seu Webhook
$webhookUri = 'PUT_YOUR_URL_WEBHOOK'

#Busca as informações do Hardware
$SystemInfo = Get-WmiObject -Class Win32_ComputerSystem

#Busca as informações do SO
$NameSO = Get-WMIObject win32_operatingsystem | Select Name  

#Busca as informações dos usuários
$users = (gci 'C:\Users' | % { $_.Name }) -join ', '

$Body = @{
  'username' = 'Webhook'
  'content' = 
   "Nome do Computador = $($SystemInfo.Name)
    Sistema Operacional =  $($NameSO.Name)
    Total de Memoria RAM =  $([math]::Round($SystemInfo.TotalPhysicalMemory / 1GB, 2)) GB
    Usuarios = $($Users)" 
}

Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body