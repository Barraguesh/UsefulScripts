#Script I did for a blog post that was used to create a phishing email address and server to send emails from.

$SMTPServer = "127.0.0.1"
$SMTPPort = "25"
$Username = "test@mail.fakedomain.com"
$Password = "12345"
$SMTPMessage = New-Object System.Net.Mail.MailMessage
$SMTPMessage.From = "ceo@microsoft.com"
$SMTPMessage.To.Add("victim@test.com")
$SMTPMessage.ReplyTo = "malicious@email.com"
$SMTPMessage.Subject = "Emergency transfer"
$SMTPMessage.IsBodyHtml = $true
$SMTPMessage.Body = "I need to transfer money ASAP!"
$SMTPClient = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort);
$SMTPClient.EnableSSL = $false
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($Username, $Password);
$SMTPClient.Send($SMTPMessage)
