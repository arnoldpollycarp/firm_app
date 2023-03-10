defmodule FirmApp.Mailer do
  # use Swoosh.Mailer, otp_app: :firm_app
  @config domain: Application.get_env(:firm_app, :mailgun_domain),
    key: Application.get_env(:firm_app, :mailgun_key)
    use Mailgun.Client, @config

  def welcome_mail(user, code) do
    send_email(
      to: user.email,
      from: "Evans Opiyo Lawfirm <info@exmple.org>",
      subject: "Confirmation Email!",
      html:
        "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
          <html xmlns='http://www.w3.org/1999/xhtml'>
          <head>
            <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
            <title> Email </title>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'/>
          </head>
          <body>
          <div style='background:#eee;width:100%;height:500px;padding-top:50px;'>
          <table align='center' border='0' cellpadding='0' cellspacing='0' width='600' style='border-collapse: collapse;'>
          <tr>
          <td align='center' bgcolor='gold' style='padding: 10px 0 10px 0;'>
            Confrimation Instructions
          </td>
          </tr>

          <tr>
          <td bgcolor='ghostwhite' style='padding: 40px 30px 40px 30px;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td style='padding: 20px 0 30px 0;'>
                  Hi #{user.email},
                  You can confirm your account by using the code below:
                  #{code}
                  If you didn't create an account with us, please ignore this.
                  </td>
                  </tr>
                  <tr>
                  </tr>
                  </table>
            </td>
          </tr>

          <tr>
          <td bgcolor='#ef001d' style='padding: 30px 30px 30px 30px;color: #f5f5f5;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td width='75%'>
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script> Opiyo Evans Lawfirm. All Rights Reserved<br/>

                      </td>
                    <td width='25%'>
                    Opiyo Evans Lawfirm
                  </td>
                  </tr>
                  </table>
            </td>
          </tr>
          </table>
          </div>
          </body>
          </html>",
      text: "Thanks for joining!"
    )
  end


  def welcome_client_mail(email, password) do
    send_email(
      to: email,
      from: "Evanas Opiyo Lawfirm <info@example.org>",
      subject: "Confirmation Email!",
      html:
        "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
          <html xmlns='http://www.w3.org/1999/xhtml'>
          <head>
            <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
            <title> Email </title>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'/>
          </head>
          <body>
          <div style='background:#eee;width:100%;height:500px;padding-top:50px;'>
          <table align='center' border='0' cellpadding='0' cellspacing='0' width='600' style='border-collapse: collapse;'>
          <tr>
          <td align='center' bgcolor='gold' style='padding: 10px 0 10px 0;'>
            Confrimation Instructions
          </td>
          </tr>

          <tr>
          <td bgcolor='ghostwhite' style='padding: 40px 30px 40px 30px;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td style='padding: 20px 0 30px 0;'>
                  Hi #{email},
                  below are your login credentials to OPIYO LAWFIRM APP:
                  Email: #{email} and Password: #{password}
                  If you didn't create an account with us, please ignore this.
                  </td>
                  </tr>
                  <tr>
                  </tr>
                  </table>
            </td>
          </tr>

          <tr>
          <td bgcolor='#ef001d' style='padding: 30px 30px 30px 30px;color: #f5f5f5;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td width='75%'>
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script> Evans Opiyo Lawfirm. All Rights Reserved<br/>

                      </td>
                    <td width='25%'>
                    Evans Opiyo Lawfirm
                  </td>
                  </tr>
                  </table>
            </td>
          </tr>
          </table>
          </div>
          </body>
          </html>",
      text: "Thanks for joining!"
    )
  end

  def reset_mailer(email, code) do
    send_email(
      to: email,
      from: "Evanas Opiyo Lawfirm <info@example.org>",
      subject: "Reset Code!",
      html:
        "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
          <html xmlns='http://www.w3.org/1999/xhtml'>
          <head>
            <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
            <title> Email </title>
            <meta name='viewport' content='width=device-width, initial-scale=1.0'/>
          </head>
          <body>
          <div style='background:#eee;width:100%;height:500px;padding-top:50px;'>
          <table align='center' border='0' cellpadding='0' cellspacing='0' width='600' style='border-collapse: collapse;'>
          <tr>
          <td align='center' bgcolor='gold' style='padding: 10px 0 10px 0;'>
            Confrimation Instructions
          </td>
          </tr>

          <tr>
          <td bgcolor='ghostwhite' style='padding: 40px 30px 40px 30px;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td style='padding: 20px 0 30px 0;'>
                  Hi #{email},
                  below is your Activation Code to OPIYO LAWFIRM APP:
                  Code: #{code}
                  If you didn't create an account with us, please ignore this.
                  </td>
                  </tr>
                  <tr>
                  </tr>
                  </table>
            </td>
          </tr>

          <tr>
          <td bgcolor='#ef001d' style='padding: 30px 30px 30px 30px;color: #f5f5f5;'>
                  <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                  <tr>
                  <td width='75%'>
                    &copy;
                    <script>
                        document.write(new Date().getFullYear())
                    </script> Evans Opiyo Lawfirm. All Rights Reserved<br/>

                      </td>
                    <td width='25%'>
                    Evans Opiyo Lawfirm
                  </td>
                  </tr>
                  </table>
            </td>
          </tr>
          </table>
          </div>
          </body>
          </html>",
      text: "Thanks for joining!"
    )
  end
end
