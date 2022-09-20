Map<String, Map<String, String>> defaultTranslation = {
  'nl': {
    // backend/appshellbackend.dart
    'screen.controltype.name': 'value',
    'login.error.user_or_password_unknown':
        'Gebruikersnaam of wachtwoord is niet bekend',
    'login.error.connection_required':
        'Een verbinding met het internet is benodigd om in te loggen',
    'login.error.email_unknown.registrationActive':
        'E-mailadres is niet bekend, check uw e-mailadres of maak een account aan',
    'login.error.email_unknown.registrationNotActive':
        'E-mailadres is niet bekend, check uw e-mailadres',
    'login.error.password_invalid': 'Wachtwoord is onjuist',
    'login.error.invalid_email': 'E-mailadres is onjuist geformatteerd',
    'login.error.too_many_attempts': 'U heeft te vaak proberen in te loggen',

    // appshell.dart
    'splash.button.text': 'Start',
    'login.text.title': 'Login',
    'login.text.subtitle': '',

    // widgets/sign_out_dialog.dart
    'signout.dialog.text.title': 'Uitloggen',
    'signout.dialog.text.body': 'Weet je zeker dat je wilt uitloggen?',

    // widgets/change_password_screen.dart
    'change_password.text.title': 'Wachtwoord wijzigen',
    'change_password.input.current_password.label': 'Huidig wachtwoord',
    'change_password.input.current_password.error': 'Onjuist wachtwoord',
    'change_password.input.new_password.label': 'Nieuw wachtwoord',
    'change_password.input.new_password.error':
        'Wachtwoord moet minstens 8 tekens lang zijn',
    'change_password.input.repeat_new_password.label':
        'Herhaal nieuw wachtwoord',
    'change_password.input.repeat_new_password.error':
        'Wachtwoorden komen niet overeen',
    'change_password.input.current_password.error.dialog.title':
        'Het wachtwoord is onjuist',
    'change_password.input.current_password.error.dialog.description':
        'Probeer het opnieuw om je huidige wachtwoord in te vullen',
    'change_password.input.current_password.error.dialog.button': 'Opnieuw',
    'change_password.button.submit': 'Wijzigen',
    'change_password.dialog.text.title': 'Wachtwoord aangepast',
    'change_password.dialog.text.body':
        'Je wachtwoord is aangepast, vanaf nu kan je inloggen met je nieuwe wachtwoord!',
    'change_password.dialog.button.close': 'Sluiten',

    // plugins/settings/input_field_generator.dart
    'settings.control.textfield.error.not_empty': 'Dit veld is verplicht!',

    // plugins/registration/registration.dart
    'registration.text.title': 'Registreren',
    'registration.text.subtitle': 'Voer een e-mailadres\nen wachtwoord in',
    'registration.text.subtitle_terms': 'Algemene Voorwaarden',
    'registration.input.email.label': 'E-mailadres',
    'registration.input.email.error.invalid_email':
        'E-mailadres is onjuist geformatteerd',
    'registration.input.password.label': 'Wachtwoord',
    'registration.input.confirmation.label': 'Herhaal Wachtwoord',
    'registration.input.password.error.password_length':
        'Wachtwoord moet minstens 8 tekens lang zijn',
    'registration.input.confirmation.error.confirmation_mismatch':
        'Herhaling komt niet overeen met wachtwoord',
    'registration.input.accept_terms.label':
        'Ik accepteer de algemene voorwaarden',
    'registration.input.accept_terms.error':
        'U moet de voorwaarden accepteren om verder te gaan',
    'registration.button.submit': 'Registreren',
    'registration.error.email_in_use.title': 'Email adres in gebruik',
    'registration.error.email_in_use.body':
        'Dit email adres wordt al gebruikt voor\neen andere inlog methode',
    'registration.error.email_in_use.button': 'Terug naar inlogscherm',
    'registration.error_dialog.text.title': 'Fout tijdens het registreren',
    'registration.error_dialog.text.body':
        'Als u deze fout vaker ziet neem dan contact op de ontwikkelaar',
    'registration.error_dialog.button.label': 'Ok',

    // plugins/registration/registration_custom_pages.dart
    'registration_custom_page.text.title': 'Registreren',
    'registration_custom_page.error.required':
        'Vul alle verplichte velden in (*)',
    'registration_custom_page.button.next': 'Volgende',

    // plugins/registration/email_know_dialog
    'registration_email_known.dialog.text.title': 'Goed nieuws!',
    'registration_email_known.dialog.text.body':
        'Je e-mailadres heeft al een account.\nJe kan direct inloggen!',
    'registration_email_known.dialog.button.login': 'Inloggen',

    // plugins/registration/registration_wizard.dart
    'registration_wizard.text.title': 'Nog geen account?',
    'registration_wizard.text.subtitle': 'Maak een nieuw account aan!',
    'registration_wizard.text.divider': 'Of',
    'registration_wizard.button.register_with_email': 'Registreer met email',
    'registration_wizard.button.register_with_phone_number':
        'Registreer met telefoonnummer',
    'registration_wizard.button.login': 'Inloggen',
    'registration_wizard.button.back': 'Terug',

    // plugins/registration/confirmation.dart
    'registration_confirmation.dialog.text.title':
        'Je bent succesvol geregistreerd',
    'registration_confirmation.dialog.text.subtitle_1':
        'Een account is aangemaakt.\n Probeer opnieuw te registreren.',
    'registration_confirmation.dialog.text.subtitle_2_part_1':
        'U heeft een account aangemaakt voor het e-mailadres: ',
    'registration_confirmation.dialog.text.subtitle_2_part_2':
        '\n Is dit e-mailadres niet correct? Registreer dan opnieuw',
    'registration_confirmation.dialog.button.register': 'Registreer opnieuw',
    'registration_confirmation.dialog.button.login': 'Inloggen',

    // plugins/login/resend.dart
    'login_resend_email.dialog.text.title': 'Opnieuw verstuurd!',
    'login_resend_email.dialog.text.body':
        'De email is opnieuw verstuurd naar uw email.\nControlleer uw spam inbox',
    'login_resend_email.dialog.button.ok': 'Ok',

    // plugins/login/choose_login.dart
    'login.text.divider': 'Of',
    'login.button.login_email': 'Login met email',
    'login.button.no_account': 'Ik heb nog geen account',
    'login.button.login_phone_number': 'Login met telefoonnummer',

    // plugins/login/login_email_password.dart
    'login.text.login_email': 'Inloggen met e-mailadres',
    'login.input.email': 'E-mailadres',
    'login.input.password': 'Wachtwoord',
    'login.input.stay_logged_in': 'Blijf ingelogd',
    'login.button.login_email_password': 'Log in met wachtwoord',
    'login.button.login_email_only': 'Log in met link',
    'login.button.login': 'Log in',
    'login.button.forgot_password': 'Wachtwoord vergeten?',

    // plugins/login/login_await_email.dart
    'login_await_email.text.title': 'Email verstuurd',
    'login_await_email.text.sent_to_part_1': 'Email is verstuurd naar ',
    'login_await_email.text.sent_to_part_2':
        'Als uw email bestaat kan u met de opgestuurde link inloggen. \n\n Controleer je spam-map\n',
    'login_await_email.button.resend': 'Verstuur opnieuw',

    // plugins/login/login_phone_number.dart
    'login_phone_number.input.phone_number': 'Telefoonnummer',
    'login_phone_number.text.error.invalid_phone_number':
        'Ongeldig telefoonnummer',
    'login_phone_number.text.error.verification_failed': 'Verificatie mislukt',
    'login_phone_number.button.submit': 'Volgende',

    // plugins/login/login_phone_number_verify.dart
    'login_phone_number_verify.text.title':
        'Vul de code in die we zojuist\nper sms verstuurd hebben',
    'login_phone_number_verify.text.nothing_received_yet':
        'Heb je niks ontvangen?',
    'login_phone_number_verify.button.send_again': 'Verstuur sms opnieuw',
    'login_phone_verify.text.send_again': 'sms opnieuw verstuurd',
    'login_phone_number_verify.text.error.wrong_code': 'Onjuiste sms code',

    // plugins/login/forgot_password.dart
    'forgot_password.text.title': 'Wachtwoord vergeten?',
    'forgot_password.text.body':
        'Vul je e-mailadres in.\nWij sturen je een mail met een link om je wachtwoord te kunnen herstellen.',
    'forgot_password.input.email': 'E-mailadres',
    'forgot_password.error.invalid_email': 'Ongeldig e-mailadres',
    'forgot_password.error.email_does_not_exist':
        'Geen account gevonden met het opgegeven e-mailadres.',
    'forgot_password.button.submit': 'Verstuur',
    'forgot_password.dialog.text.title': 'Nieuw wachtwoord',
    'forgot_password.dialog.text.body': r'Er is een link naar %1$ verstuurd.',
    'forgot_password.dialog.text.button': 'Terug naar login',

    // plugins/dialog/alert_dialog.dart
    'alertdialog.button.yes': 'Ja',
    'alertdialog.button.no': 'Nee',

    // social login buttons
    'SocialLoginMethod.Google': 'Google',
    'SocialLoginMethod.FaceBook': 'Facebook',
    'SocialLoginMethod.Apple': 'Apple',
    'SocialLoginMethod.LinkedIn': 'Linked-In',
    'SocialLoginMethod.Microsoft': 'Microsoft',
    'SocialLoginMethod.Twitter': 'Twitter',

    // plugins/form/libraries/appshell/lib.dart
    'appshell_input_library.date.picker.help_text': 'Selecteer een datum',
    'appshell_input_library.date.picker.cancel_text': 'Annuleren',
    'appshell_input_library.date.picker.confirm_text': 'Oké',
    'appshell_input_library.date.picker.error_format_text': 'Ongeldige datum',
    'appshell_input_library.date.picker.error_invalid_text': 'Buiten bereik',
    'appshell_input_library.date.picker.field_label_text': 'Datum',
    'appshell_input_library.date_range.picker.help_text': 'Selecteer bereik',
    'appshell_input_library.date_range.picker.cancel_text': 'Annuleren',
    'appshell_input_library.date_range.picker.confirm_text': 'Oké',
    'appshell_input_library.date_range.picker.save_text': 'Opslaan',
    'appshell_input_library.date_range.picker.error_format_text':
        'Ongeldige datum',
    'appshell_input_library.date_range.picker.error_invalid_text':
        'Buiten bereik',
    'appshell_input_library.date_range.picker.error_invalid_range_text':
        'Ongeldig bereik',
    'appshell_input_library.date_range.picker.field_start_label_text':
        'Start datum',
    'appshell_input_library.date_range.picker.field_end_label_text':
        'Eind datum',
    'appshell_input_library.time.picker.help_text': 'Selecteer een tijd',
    'appshell_input_library.time.picker.cancel_text': 'Annuleren',
    'appshell_input_library.time.picker.confirm_text': 'Oké',
  },
};
