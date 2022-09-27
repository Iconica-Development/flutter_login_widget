Map<String, Map<String, String>> defaultTranslation = {
  'nl': {
    // backend/appshellbackend.dart
    'screen.controltype.name': 'value',
    'login.error.user_or_password_unknown':
        'Gebruikersnaam of wachtwoord is niet bekend',
    'login.error.connection_required':
        'Een verbinding met het internet is benodigd om in te loggen',
    'login.error.email_unknown': 'E-mailadres is niet bekend',
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

    // plugins/settings/input_field_generator.dart
    'settings.control.textfield.error.not_empty': 'Dit veld is verplicht!',

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
    'login.text.enter_email': 'Geef uw e-mailadres op',
    'login.text.enter_password': 'Geef uw wachtwoord op',

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
        'Geen account gevonden met het e-mailadres.',
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
