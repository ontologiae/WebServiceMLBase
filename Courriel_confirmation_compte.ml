

let string ~prenom ~nom ~login ~lien_confirm  () = Printf.sprintf "<html lang=\"fr\"><head> 
        <meta charset=\"utf-8\">
        <title>email d'activation de compte</title>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        <meta name=\"description\" content=\"\">
    </head>    
    <body>
	<table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\">
		<tbody>	
	
		<tr valign=\"top\" align=\"center\">
			<td style=\"padding-bottom:20px\">
				<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#fff\" style=\"width:640px\">
				<tbody style=\"font-family: 'raleway', helvetica, arial;\">
					<tr style=\"background-position: right top; background-image: url(http://marketing.cowebo.com/img/entete_mail.png); background-repeat: no-repeat;text-transform: uppercase;\">
						<td style=\"height: 121px;\">
						<b style=\"padding-left: 30px; color: darkslategray;\">Activation de votre compte</b>
						</td>
					</tr>
					<tr>
						<td style=\"color:#444444;\">
							<div style=\"margin: -20px 0px 0px 11px;background-color: #F6F6F6;padding: 20px;\"><p
								style=\"font-size:12px;line-height:18px\">Bonjour %s %s, 
							<br><br>
							Vous avez demandé la création d'un compte cowebo pour le compte <b>%s</b>.
							<br><br>
							Nous vous remerçions de votre confiance!
							<br><br>
							Merci de confirmer votre adresse email pour activer votre compte grace au lien
							suivant : <br><a href=\"%s\"><b>Confirmer maintenant !</b></a>
							<br><br>
							<i>
							Le lien ne fonctionne pas? Copiez l'adresse suivante dans votre navigateur:
							<br>
							%s
							</i>
							<br><br>
							À vous de signer!<br>
							L'équipe Cowebo<br><br>
							Si vous avez la moindre question concernant cette email, vous pouvez consulter la FAQ dédiée : <a href=\"#\" target=\"_blank\">FAQ</a>.
							</p>
							<hr>
							<p style=\"color: rgb(189, 188, 188);font-size: 11px;padding-left: 30px;\">
							Cowebo SAS - 2, rue Paul Painlevé 44000 Nantes  - RCS de Nantes 537 538 613
							</p>
							</div>				
						</td>
					</tr>
					<tr style=\"background-position: right top;background-image: url(http://marketing.cowebo.com/img/pied_mail.png); background-repeat: no-repeat;\">			
						<td style=\"padding: 20px;\">
							<p style=\"font-family:Georgia,'Lucida Grande',Verdana,Helvetica,Arial,sans-serif;line-height:15px;color:#aaaaaa;font-size:11px;margin:4px 0 0 0\">
							Cet email vous a été envoyé par <strong style=\"color:#aaaaaa\"><a href=\"http://www.cowebo.com\" target=\"_blank\">cowebo.com</a></strong>, la plateforme de confiance de contractualisation en ligne: Signez, diffusez, archivez, communiquez.
							<br><em>Veuillez nous contacter si vous pensez avoir reçu cet email par erreur.</em>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
	        </td>
           </tr>
    </tbody>
</table>        
</body>
</html>
" prenom nom login lien_confirm lien_confirm





let envoi_message_plateforme_cowebo ~prenom ~nom ~contenu_message  () = 
        Printf.sprintf "<html lang=\"fr\"><head> 
        <meta charset=\"utf-8\">
        <title>email d'activation de compte</title>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        <meta name=\"description\" content=\"\">
    </head>    
    <body>
	<table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\">
		<tbody>	
	
		<tr valign=\"top\" align=\"center\">
			<td style=\"padding-bottom:20px\">
				<table cellpadding=\"0\" cellspacing=\"0\" bgcolor=\"#fff\" style=\"width:640px\">
				<tbody style=\"font-family: 'raleway', helvetica, arial;\">
					<tr style=\"background-position: right top; background-image: url(http://marketing.cowebo.com/img/entete_mail.png); background-repeat: no-repeat;text-transform: uppercase;\">
						<td style=\"height: 121px;\">
						<b style=\"padding-left: 30px; color: darkslategray;\">Activation de votre compte</b>
						</td>
					</tr>
					<tr>
						<td style=\"color:#444444;\">
							<div style=\"margin: -20px 0px 0px 11px;background-color: #F6F6F6;padding: 20px;\"><p
								style=\"font-size:12px;line-height:18px\">Bonjour, 
							<br><br>
							%s %s vous a envoyé un message sur la plateforme <a href=\"http://webapp.cowebo.com\">Cowebo</a>.
							<br><br>
							%s %s a écrit : \"%s\"
							<br><br>
							Vous pouvez répondre à ce message en vous connectant à votre plateforme <a href=\"http://webapp.cowebo.com\">Cowebo</a> </b></a>
							<br><br>
							L'équipe Cowebo<br><br>
							Si vous avez la moindre question concernant cette email, vous pouvez consulter la FAQ dédiée : <a href=\"#\" target=\"_blank\">FAQ</a>.
							</p>
							<hr>
							<p style=\"color: rgb(189, 188, 188);font-size: 11px;padding-left: 30px;\">
							Cowebo SAS - 2, rue Paul Painlevé 44000 Nantes  - RCS de Nantes 537 538 613
							</p>
							</div>				
						</td>
					</tr>
					<tr style=\"background-position: right top;background-image: url(http://marketing.cowebo.com/img/pied_mail.png); background-repeat: no-repeat;\">			
						<td style=\"padding: 20px;\">
							<p style=\"font-family:Georgia,'Lucida Grande',Verdana,Helvetica,Arial,sans-serif;line-height:15px;color:#aaaaaa;font-size:11px;margin:4px 0 0 0\">
							Cet email vous a été envoyé par <strong style=\"color:#aaaaaa\"><a href=\"http://www.cowebo.com\" target=\"_blank\">cowebo.com</a></strong>, la plateforme de confiance de contractualisation en ligne: Signez, diffusez, archivez, communiquez.
							<br><em>Veuillez nous contacter si vous pensez avoir reçu cet email par erreur.</em>
							</p>
						</td>
					</tr>
				</tbody>
			</table>
	        </td>
           </tr>
    </tbody>
</table>        
</body>
</html>
" prenom nom  prenom nom  contenu_message

