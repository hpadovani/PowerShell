$dia = "{0:dd}" -f (get-date)
$mes = "{0:MM}" -f (get-date)
$ano = (Get-Date).year
$filename = “NOME_DO_ARQUIVO" + $mes +"-"+ $dia +"-"+ $ano + ".log”
$smtpServer = “smtp.dominio.com.br”
$msg = new-object Net.Mail.MailMessage
$att = new-object Net.Mail.Attachment($filename)
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$msg.From = “e-mail que enviara as mensagens ”
$msg.To.Add(”e-mail que irá receber as mensagens”)   
$msg.IsBodyHTML = $true    

  if(Get-Content $filename | Select-String "Successfully")  {
      
      $msg.Subject = “Titulo do e-mail”
      $line1 = “Sucesso.”  
      $line2 = Get-Content $filename | Select-String "Successfully"  \\verifica o arquivo procurando a palavra da select-string
                 
      $msg.Body = "<b><font color=Green>Sucesso</b></font>.`n`n<b><font color=Green>$line2</b></font>"
  
  }else  {
           
      $msg.Subject = “Titulo do e-mail com Falha”
      #$line1 = “Falha.”
      #$msg.Body = "<b><font color=Red>$line1</b></font> "
      $msg.Body = "<b><font color=Red>Falha</b></font>."

      
    }   
  
  
  
$msg.Attachments.Add($att)
$smtp.Send($msg)