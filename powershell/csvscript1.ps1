#Importer les données  
$CSVFILE = "C:\Scripts\UserList2.csv"
$CSVData = Import-CSV -Path $CSVFILE -Delimiter ";" -Encoding UTF8

# Fonction pour générer des mots de passe aléatoires
Function Generate-Password {
    $Length = 12
    $Chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'
    -join ((Get-Random -Count $Length -InputObject $Chars.ToCharArray()) -join '')
}

# Boucle Foreach pour parcourir chaque utilisateur
Foreach ($Utilisateur in $CSVData) {
    # Vérifier les champs obligatoires
    If (-not $Utilisateur.Firstname -or -not $Utilisateur.Lastname -or -not $Utilisateur.Email -or -not $Utilisateur.Username) {
        Write-Warning "Données incomplètes pour l'utilisateur. Ligne ignorée."
        Continue
    }

    $UtilisateurPrenom = $Utilisateur.Firstname
    $UtilisateurNom = $Utilisateur.Lastname
    $UtilisateurEmail = $Utilisateur.Email
    $UtilisateurUsername = $Utilisateur.Username
    $UtilisateurMotDePasse = "Fd@nd8I4DBv0z?nJXSS"
    $UtilisateurLogin = "$UtilisateurPrenom.$($UtilisateurNom.ToLower())"
    $UtilisateurUPN = $($UtilisateurPrenom.ToLower())+"."+$($UtilisateurNom.Tolower())+"@supremeauto.fr"

    # Vérifier si le UserPrincipalName est trop long
    if ($UtilisateurLogin.Length -gt 64) {
        $UtilisateurLogin = ($UtilisateurPrenom.Substring(0,1))+"."+$($UtilisateurNom.ToLower())
    }

    # Vérifier si le SamAccountName est trop long
    if ($UtilisateurUsername.Length -gt 20) {
        $UtilisateurUsername = ($UtilisateurPrenom.Substring(0,1))+"."+"$UtilisateurNom"
    }

    # Forcer la création même en cas de conflit
    try {
        New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                   -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                   -GivenName "$UtilisateurPrenom" `
                   -Surname "$UtilisateurNom" `
                   -SamAccountName "$UtilisateurUsername" `
                   -UserPrincipalName "$UtilisateurUPN" `
                   -EmailAddress "$UtilisateurEmail" `
                   -Path "OU=site-test,DC=SUPREMEAUTO,DC=FR" `
                   -AccountPassword (ConvertTo-SecureString "$UtilisateurMotDePasse" -AsPlainText -Force) `
                   -ChangePasswordAtLogon $true `
                   -Enabled $true `
                   -Server "Srv-Ad-Racine.supremeAuto.fr" -ErrorAction Stop
        Write-Output "Création réussie pour l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom)"
    } catch {
        Write-Warning "Forçage de la création pour l'utilisateur $UtilisateurUsername avec un SamAccountName alternatif."
        $UtilisateurUsername = "$($UtilisateurPrenom.Substring(0,1))$($UtilisateurNom.Substring(0,19))"
        try {
            New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                       -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                       -GivenName "$UtilisateurPrenom" `
                       -Surname "$UtilisateurNom" `
                       -SamAccountName "$UtilisateurUsername" `
                       -UserPrincipalName "$UtilisateurLogin@supremeauto.fr" `
                       -EmailAddress "$UtilisateurEmail" `
                       -Path "OU=site-test,DC=SUPREMEAUTO,DC=FR" `
                       -AccountPassword (ConvertTo-SecureString "$UtilisateurMotDePasse" -AsPlainText -Force) `
                       -ChangePasswordAtLogon $true `
                       -Enabled $true `
                       -Server "Srv-Ad-Racine.supremeAuto.fr"
            Write-Output "Création forcée réussie pour l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom)"
        } catch {
            Write-Error "Échec total pour l'utilisateur $UtilisateurUsername : $_"
        }
    }
}

