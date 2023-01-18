import '../../settings.dart';

///
class CountryData {
  CountryData._();

  static List<Country> get supportedCountry => _mappingData();

  static List<Country> get supportedLanguageCountry => _getSupportLangCountry();

  static List<Country> _getSupportLangCountry() {
    var data =
        _countryList.where((element) => element['language'] == true).toList();
    return data
        .map((e) => Country(
              dialCode: e['dial_code'],
              code: (e['language_code'] ?? e['country_code'])
                  .toString()
                  .toLowerCase(),
              flag: 'assets/images/flags/'
                  '${e['country_code'].toString().toLowerCase()}'
                  '.png',
              name: e['language_name'] ?? e['name'],
            ))
        .toList();
  }

  static List<Country> _mappingData() => _countryList
      .map((e) => Country(
            code: e['country_code'].toString().toLowerCase(),
            dialCode: e['dial_code'],
            flag: 'assets/images/flags/'
                '${e['country_code'].toString().toLowerCase()}'
                '.png',
            name: e['name'],
          ))
      .toList();

  static final List<Map<String, dynamic>> _countryList = [
    {
      'country_code': 'ID',
      'name': 'Indonesia',
      'dial_code': '+62',
      'language': true,
    },
    {'country_code': 'VN', 'name': 'Vietnam', 'dial_code': '+84'},
    {'country_code': 'TH', 'name': 'Thailand', 'dial_code': '+66'},
    {'country_code': 'SG', 'name': 'Singapore', 'dial_code': '+65'},
    {'country_code': 'MY', 'name': 'Malaysia', 'dial_code': '+60'},
    {'country_code': 'BN', 'name': 'Brunei Darussalam', 'dial_code': '+673'},
    {'country_code': 'MM', 'name': 'Myanmar', 'dial_code': '+95'},
    {'country_code': 'AF', 'name': 'Afghanistan', 'dial_code': '+93'},
    {'country_code': 'AX', 'name': 'Åland Islands', 'dial_code': '+358'},
    {'country_code': 'AL', 'name': 'Albania', 'dial_code': '+355'},
    {'country_code': 'DZ', 'name': 'Algeria', 'dial_code': '+213'},
    {'country_code': 'AS', 'name': 'American Samoa', 'dial_code': '+1684'},
    {'country_code': 'AD', 'name': 'Andorra', 'dial_code': '+376'},
    {'country_code': 'AO', 'name': 'Angola', 'dial_code': '+244'},
    {'country_code': 'AI', 'name': 'Anguilla', 'dial_code': '+1264'},
    {'country_code': 'AQ', 'name': 'Antarctica', 'dial_code': '+672'},
    {'country_code': 'AG', 'name': 'Antigua and Barbuda', 'dial_code': '+1268'},
    {'country_code': 'AR', 'name': 'Argentina', 'dial_code': '+54'},
    {'country_code': 'AM', 'name': 'Armenia', 'dial_code': '+374'},
    {'country_code': 'AW', 'name': 'Aruba', 'dial_code': '+297'},
    {'country_code': 'AU', 'name': 'Australia', 'dial_code': '+61'},
    {'country_code': 'AT', 'name': 'Austria', 'dial_code': '+43'},
    {'country_code': 'AZ', 'name': 'Azerbaijan', 'dial_code': '+994'},
    {'country_code': 'BS', 'name': 'Bahamas', 'dial_code': '+1242'},
    {'country_code': 'BH', 'name': 'Bahrain', 'dial_code': '+973'},
    {'country_code': 'BD', 'name': 'Bangladesh', 'dial_code': '+880'},
    {'country_code': 'BB', 'name': 'Barbados', 'dial_code': '+1246'},
    {'country_code': 'BY', 'name': 'Belarus', 'dial_code': '+375'},
    {'country_code': 'BE', 'name': 'Belgium', 'dial_code': '+32'},
    {'country_code': 'BZ', 'name': 'Belize', 'dial_code': '+501'},
    {'country_code': 'BJ', 'name': 'Benin', 'dial_code': '+229'},
    {'country_code': 'BM', 'name': 'Bermuda', 'dial_code': '+1441'},
    {'country_code': 'BT', 'name': 'Bhutan', 'dial_code': '+975'},
    {
      'country_code': 'BO',
      'name': 'Bolivia (Plurinational State of)',
      'dial_code': '+591'
    },
    {
      'country_code': 'BA',
      'name': 'Bosnia and Herzegovina',
      'dial_code': '+387'
    },
    {'country_code': 'BW', 'name': 'Botswana', 'dial_code': '+267'},
    {'country_code': 'BV', 'name': 'Bouvet Island', 'dial_code': '+47'},
    {'country_code': 'BR', 'name': 'Brazil', 'dial_code': '+55'},
    {
      'country_code': 'IO',
      'name': 'British Indian Ocean Territory',
      'dial_code': '+246'
    },
    {'country_code': 'BG', 'name': 'Bulgaria', 'dial_code': '+359'},
    {'country_code': 'BF', 'name': 'Burkina Faso', 'dial_code': '+226'},
    {'country_code': 'BI', 'name': 'Burundi', 'dial_code': '+257'},
    {'country_code': 'CV', 'name': 'Cabo Verde', 'dial_code': '+238'},
    {'country_code': 'KH', 'name': 'Cambodia', 'dial_code': '+855'},
    {'country_code': 'CM', 'name': 'Cameroon', 'dial_code': '+237'},
    {'country_code': 'CA', 'name': 'Canada', 'dial_code': '+1'},
    {'country_code': 'KY', 'name': 'Cayman Islands', 'dial_code': '+1345'},
    {
      'country_code': 'CF',
      'name': 'Central African Republic',
      'dial_code': '+236'
    },
    {'country_code': 'TD', 'name': 'Chad', 'dial_code': '+235'},
    {'country_code': 'CL', 'name': 'Chile', 'dial_code': '+56'},
    {'country_code': 'CN', 'name': 'China', 'dial_code': '+86'},
    {'country_code': 'CX', 'name': 'Christmas Island', 'dial_code': '+61'},
    {
      'country_code': 'CC',
      'name': 'Cocos (Keeling) Islands',
      'dial_code': '+61'
    },
    {'country_code': 'CO', 'name': 'Colombia', 'dial_code': '+57'},
    {'country_code': 'KM', 'name': 'Comoros', 'dial_code': '+269'},
    {
      'country_code': 'CG',
      'name': 'Congo (Republic of the)',
      'dial_code': '+242'
    },
    {
      'country_code': 'CD',
      'name': 'Congo (Democratic Republic of the)',
      'dial_code': '+243'
    },
    {'country_code': 'CK', 'name': 'Cook Islands', 'dial_code': '+682'},
    {'country_code': 'CR', 'name': 'Costa Rica', 'dial_code': '+506'},
    {'country_code': 'CI', 'name': 'Côte d\'Ivoire', 'dial_code': '+225'},
    {'country_code': 'HR', 'name': 'Croatia', 'dial_code': '+385'},
    {'country_code': 'CU', 'name': 'Cuba', 'dial_code': '+53'},
    {'country_code': 'CY', 'name': 'Cyprus', 'dial_code': '+357'},
    {'country_code': 'CZ', 'name': 'Czech Republic', 'dial_code': '+420'},
    {'country_code': 'DK', 'name': 'Denmark', 'dial_code': '+45'},
    {'country_code': 'DJ', 'name': 'Djibouti', 'dial_code': '+253'},
    {'country_code': 'DM', 'name': 'Dominica', 'dial_code': '+1767'},
    {'country_code': 'DO', 'name': 'Dominican Republic', 'dial_code': '+1849'},
    {'country_code': 'EC', 'name': 'Ecuador', 'dial_code': '+593'},
    {'country_code': 'EG', 'name': 'Egypt', 'dial_code': '+20'},
    {'country_code': 'SV', 'name': 'El Salvador', 'dial_code': '+503'},
    {'country_code': 'GQ', 'name': 'Equatorial Guinea', 'dial_code': '+240'},
    {'country_code': 'ER', 'name': 'Eritrea', 'dial_code': '+291'},
    {'country_code': 'EE', 'name': 'Estonia', 'dial_code': '+372'},
    {'country_code': 'ET', 'name': 'Ethiopia', 'dial_code': '+251'},
    {
      'country_code': 'FK',
      'name': 'Falkland Islands (Malvinas)',
      'dial_code': '+500'
    },
    {'country_code': 'FO', 'name': 'Faroe Islands', 'dial_code': '+298'},
    {'country_code': 'FJ', 'name': 'Fiji', 'dial_code': '+679'},
    {'country_code': 'FI', 'name': 'Finland', 'dial_code': '+358'},
    {'country_code': 'FR', 'name': 'France', 'dial_code': '+33'},
    {'country_code': 'GF', 'name': 'French Guiana', 'dial_code': '+594'},
    {'country_code': 'PF', 'name': 'French Polynesia', 'dial_code': '+689'},
    {
      'country_code': 'TF',
      'name': 'French Southern Territories',
      'dial_code': '+262'
    },
    {'country_code': 'GA', 'name': 'Gabon', 'dial_code': '+241'},
    {'country_code': 'GM', 'name': 'Gambia', 'dial_code': '+220'},
    {'country_code': 'GE', 'name': 'Georgia', 'dial_code': '+995'},
    {'country_code': 'DE', 'name': 'Germany', 'dial_code': '+49'},
    {'country_code': 'GH', 'name': 'Ghana', 'dial_code': '+233'},
    {'country_code': 'GI', 'name': 'Gibraltar', 'dial_code': '+350'},
    {'country_code': 'GR', 'name': 'Greece', 'dial_code': '+30'},
    {'country_code': 'GL', 'name': 'Greenland', 'dial_code': '+299'},
    {'country_code': 'GD', 'name': 'Grenada', 'dial_code': '+1473'},
    {'country_code': 'GP', 'name': 'Guadeloupe', 'dial_code': '+590'},
    {'country_code': 'GU', 'name': 'Guam', 'dial_code': '+1671'},
    {'country_code': 'GT', 'name': 'Guatemala', 'dial_code': '+502'},
    {'country_code': 'GG', 'name': 'Guernsey', 'dial_code': '+44'},
    {'country_code': 'GN', 'name': 'Guinea', 'dial_code': '+224'},
    {'country_code': 'GW', 'name': 'Guinea-Bissau', 'dial_code': '+245'},
    {'country_code': 'GY', 'name': 'Guyana', 'dial_code': '+592'},
    {'country_code': 'HT', 'name': 'Haiti', 'dial_code': '+509'},
    {'country_code': 'VA', 'name': 'Vatican City State', 'dial_code': '+379'},
    {'country_code': 'HN', 'name': 'Honduras', 'dial_code': '+504'},
    {'country_code': 'HK', 'name': 'Hong Kong', 'dial_code': '+852'},
    {'country_code': 'HU', 'name': 'Hungary', 'dial_code': '+36'},
    {'country_code': 'IS', 'name': 'Iceland', 'dial_code': '+354'},
    {'country_code': 'IN', 'name': 'India', 'dial_code': '+91'},
    {'country_code': 'IR', 'name': 'Iran', 'dial_code': '+98'},
    {'country_code': 'IQ', 'name': 'Iraq', 'dial_code': '+964'},
    {'country_code': 'IE', 'name': 'Ireland', 'dial_code': '+353'},
    {'country_code': 'IM', 'name': 'Isle of Man', 'dial_code': '+44'},
    {'country_code': 'IL', 'name': 'Israel', 'dial_code': '+972'},
    {'country_code': 'IT', 'name': 'Italy', 'dial_code': '+39'},
    {'country_code': 'JM', 'name': 'Jamaica', 'dial_code': '+1876'},
    {'country_code': 'JP', 'name': 'Japan', 'dial_code': '+81'},
    {'country_code': 'JE', 'name': 'Jersey', 'dial_code': '+44'},
    {'country_code': 'JO', 'name': 'Jordan', 'dial_code': '+962'},
    {'country_code': 'KZ', 'name': 'Kazakhstan', 'dial_code': '+7'},
    {'country_code': 'KE', 'name': 'Kenya', 'dial_code': '+254'},
    {'country_code': 'KI', 'name': 'Kiribati', 'dial_code': '+686'},
    {
      'country_code': 'KP',
      'name': 'Korea (Democratic People\'s Republic of)',
      'dial_code': '+850'
    },
    {'country_code': 'KR', 'name': 'Korea (Republic of)', 'dial_code': '+82'},
    {'country_code': 'KW', 'name': 'Kuwait', 'dial_code': '+965'},
    {'country_code': 'KG', 'name': 'Kyrgyzstan', 'dial_code': '+996'},
    {
      'country_code': 'LA',
      'name': 'Lao People\'s Democratic Republic',
      'dial_code': '+856'
    },
    {'country_code': 'LV', 'name': 'Latvia', 'dial_code': '+371'},
    {'country_code': 'LB', 'name': 'Lebanon', 'dial_code': '+961'},
    {'country_code': 'LS', 'name': 'Lesotho', 'dial_code': '+266'},
    {'country_code': 'LR', 'name': 'Liberia', 'dial_code': '+231'},
    {'country_code': 'LY', 'name': 'Libya', 'dial_code': '+218'},
    {'country_code': 'LI', 'name': 'Liechtenstein', 'dial_code': '+423'},
    {'country_code': 'LT', 'name': 'Lithuania', 'dial_code': '+370'},
    {'country_code': 'LU', 'name': 'Luxembourg', 'dial_code': '+352'},
    {'country_code': 'MO', 'name': 'Macao', 'dial_code': '+853'},
    {
      'country_code': 'MK',
      'name': 'Macedonia (the former Yugoslav Republic of)',
      'dial_code': '+389'
    },
    {'country_code': 'MG', 'name': 'Madagascar', 'dial_code': '+261'},
    {'country_code': 'MW', 'name': 'Malawi', 'dial_code': '+265'},
    {'country_code': 'MV', 'name': 'Maldives', 'dial_code': '+960'},
    {'country_code': 'ML', 'name': 'Mali', 'dial_code': '+223'},
    {'country_code': 'MT', 'name': 'Malta', 'dial_code': '+356'},
    {'country_code': 'MH', 'name': 'Marshall Islands', 'dial_code': '+692'},
    {'country_code': 'MQ', 'name': 'Martinique', 'dial_code': '+596'},
    {'country_code': 'MR', 'name': 'Mauritania', 'dial_code': '+222'},
    {'country_code': 'MU', 'name': 'Mauritius', 'dial_code': '+230'},
    {'country_code': 'YT', 'name': 'Mayotte', 'dial_code': '+262'},
    {'country_code': 'MX', 'name': 'Mexico', 'dial_code': '+52'},
    {
      'country_code': 'FM',
      'name': 'Micronesia (Federated States of)',
      'dial_code': '+691'
    },
    {
      'country_code': 'MD',
      'name': 'Moldova (Republic of)',
      'dial_code': '+373'
    },
    {'country_code': 'MC', 'name': 'Monaco', 'dial_code': '+377'},
    {'country_code': 'MN', 'name': 'Mongolia', 'dial_code': '+976'},
    {'country_code': 'ME', 'name': 'Montenegro', 'dial_code': '+382'},
    {'country_code': 'MS', 'name': 'Montserrat', 'dial_code': '+1664'},
    {'country_code': 'MA', 'name': 'Morocco', 'dial_code': '+212'},
    {'country_code': 'MZ', 'name': 'Mozambique', 'dial_code': '+258'},
    {'country_code': 'NA', 'name': 'Namibia', 'dial_code': '+264'},
    {'country_code': 'NR', 'name': 'Nauru', 'dial_code': '+674'},
    {'country_code': 'NP', 'name': 'Nepal', 'dial_code': '+977'},
    {'country_code': 'NL', 'name': 'Netherlands', 'dial_code': '+31'},
    {'country_code': 'NC', 'name': 'New Caledonia', 'dial_code': '+687'},
    {'country_code': 'NZ', 'name': 'New Zealand', 'dial_code': '+64'},
    {'country_code': 'NI', 'name': 'Nicaragua', 'dial_code': '+505'},
    {'country_code': 'NE', 'name': 'Niger', 'dial_code': '+227'},
    {'country_code': 'NG', 'name': 'Nigeria', 'dial_code': '+234'},
    {'country_code': 'NU', 'name': 'Niue', 'dial_code': '+683'},
    {'country_code': 'NF', 'name': 'Norfolk Island', 'dial_code': '+672'},
    {
      'country_code': 'MP',
      'name': 'Northern Mariana Islands',
      'dial_code': '+1670'
    },
    {'country_code': 'NO', 'name': 'Norway', 'dial_code': '+47'},
    {'country_code': 'OM', 'name': 'Oman', 'dial_code': '+968'},
    {'country_code': 'PK', 'name': 'Pakistan', 'dial_code': '+92'},
    {'country_code': 'PW', 'name': 'Palau', 'dial_code': '+680'},
    {'country_code': 'PS', 'name': 'Palestine, State of', 'dial_code': '+970'},
    {'country_code': 'PA', 'name': 'Panama', 'dial_code': '+507'},
    {'country_code': 'PG', 'name': 'Papua New Guinea', 'dial_code': '+675'},
    {'country_code': 'PY', 'name': 'Paraguay', 'dial_code': '+595'},
    {'country_code': 'PE', 'name': 'Peru', 'dial_code': '+51'},
    {'country_code': 'PH', 'name': 'Philippines', 'dial_code': '+63'},
    {'country_code': 'PN', 'name': 'Pitcairn', 'dial_code': '+64'},
    {'country_code': 'PL', 'name': 'Poland', 'dial_code': '+48'},
    {'country_code': 'PT', 'name': 'Portugal', 'dial_code': '+351'},
    {'country_code': 'PR', 'name': 'Puerto Rico', 'dial_code': '+1939'},
    {'country_code': 'QA', 'name': 'Qatar', 'dial_code': '+974'},
    {'country_code': 'RE', 'name': 'Réunion', 'dial_code': '+262'},
    {'country_code': 'RO', 'name': 'Romania', 'dial_code': '+40'},
    {'country_code': 'RU', 'name': 'Russian Federation', 'dial_code': '+7'},
    {'country_code': 'RW', 'name': 'Rwanda', 'dial_code': '+250'},
    {'country_code': 'BL', 'name': 'Saint Barthélemy', 'dial_code': '+590'},
    {
      'country_code': 'SH',
      'name': 'Saint Helena, Ascension and Tristan da Cunha',
      'dial_code': '+290'
    },
    {
      'country_code': 'KN',
      'name': 'Saint Kitts and Nevis',
      'dial_code': '+1869'
    },
    {'country_code': 'LC', 'name': 'Saint Lucia', 'dial_code': '+1758'},
    {
      'country_code': 'MF',
      'name': 'Saint Martin (French part)',
      'dial_code': '+590'
    },
    {
      'country_code': 'PM',
      'name': 'Saint Pierre and Miquelon',
      'dial_code': '+508'
    },
    {
      'country_code': 'VC',
      'name': 'Saint Vincent and the Grenadines',
      'dial_code': '+1784'
    },
    {'country_code': 'WS', 'name': 'Samoa', 'dial_code': '+685'},
    {'country_code': 'SM', 'name': 'San Marino', 'dial_code': '+378'},
    {
      'country_code': 'ST',
      'name': 'Sao Tome and Principe',
      'dial_code': '+239'
    },
    {'country_code': 'SA', 'name': 'Saudi Arabia', 'dial_code': '+966'},
    {'country_code': 'SN', 'name': 'Senegal', 'dial_code': '+221'},
    {'country_code': 'RS', 'name': 'Serbia', 'dial_code': '+381'},
    {'country_code': 'SC', 'name': 'Seychelles', 'dial_code': '+248'},
    {'country_code': 'SL', 'name': 'Sierra Leone', 'dial_code': '+232'},
    {'country_code': 'SK', 'name': 'Slovakia', 'dial_code': '+421'},
    {'country_code': 'SI', 'name': 'Slovenia', 'dial_code': '+386'},
    {'country_code': 'SB', 'name': 'Solomon Islands', 'dial_code': '+677'},
    {'country_code': 'SO', 'name': 'Somalia', 'dial_code': '+252'},
    {'country_code': 'ZA', 'name': 'South Africa', 'dial_code': '+27'},
    {
      'country_code': 'GS',
      'name': 'South Georgia and the South Sandwich Islands',
      'dial_code': '+500'
    },
    {'country_code': 'SS', 'name': 'South Sudan', 'dial_code': '+211'},
    {'country_code': 'ES', 'name': 'Spain', 'dial_code': '+34'},
    {'country_code': 'LK', 'name': 'Sri Lanka', 'dial_code': '+94'},
    {'country_code': 'SD', 'name': 'Sudan', 'dial_code': '+249'},
    {'country_code': 'SR', 'name': 'Suriname', 'dial_code': '+597'},
    {
      'country_code': 'SJ',
      'name': 'Svalbard and Jan Mayen',
      'dial_code': '+47'
    },
    {'country_code': 'SZ', 'name': 'Swaziland', 'dial_code': '+268'},
    {'country_code': 'SE', 'name': 'Sweden', 'dial_code': '+46'},
    {'country_code': 'CH', 'name': 'Switzerland', 'dial_code': '+41'},
    {'country_code': 'SY', 'name': 'Syrian Arab Republic', 'dial_code': '+963'},
    {
      'country_code': 'TW',
      'name': 'Taiwan, Province of China',
      'dial_code': '+886'
    },
    {'country_code': 'TJ', 'name': 'Tajikistan', 'dial_code': '+992'},
    {
      'country_code': 'TZ',
      'name': 'Tanzania, United Republic of',
      'dial_code': '+255'
    },
    {'country_code': 'TL', 'name': 'Timor-Leste', 'dial_code': '+670'},
    {'country_code': 'TG', 'name': 'Togo', 'dial_code': '+228'},
    {'country_code': 'TK', 'name': 'Tokelau', 'dial_code': '+690'},
    {'country_code': 'TO', 'name': 'Tonga', 'dial_code': '+676'},
    {'country_code': 'TT', 'name': 'Trinidad and Tobago', 'dial_code': '+1868'},
    {'country_code': 'TN', 'name': 'Tunisia', 'dial_code': '+216'},
    {'country_code': 'TR', 'name': 'Turkey', 'dial_code': '+90'},
    {'country_code': 'TM', 'name': 'Turkmenistan', 'dial_code': '+993'},
    {
      'country_code': 'TC',
      'name': 'Turks and Caicos Islands',
      'dial_code': '+1649'
    },
    {'country_code': 'TV', 'name': 'Tuvalu', 'dial_code': '+688'},
    {'country_code': 'UG', 'name': 'Uganda', 'dial_code': '+256'},
    {'country_code': 'UA', 'name': 'Ukraine', 'dial_code': '+380'},
    {'country_code': 'AE', 'name': 'United Arab Emirates', 'dial_code': '+971'},
    {
      'country_code': 'GB',
      'name': 'United Kingdom of Great Britain and Northern Ireland',
      'dial_code': '+44'
    },
    {
      'country_code': 'US',
      'name': 'United States',
      'language_name': 'English',
      'language_code': 'en',
      'dial_code': '+1',
      'language': true,
    },
    {'country_code': 'UY', 'name': 'Uruguay', 'dial_code': '+598'},
    {'country_code': 'UZ', 'name': 'Uzbekistan', 'dial_code': '+998'},
    {'country_code': 'VU', 'name': 'Vanuatu', 'dial_code': '+678'},
    {
      'country_code': 'VE',
      'name': 'Venezuela (Bolivarian Republic of)',
      'dial_code': '+58'
    },
    {
      'country_code': 'VG',
      'name': 'Virgin Islands (British)',
      'dial_code': '+1284'
    },
    {
      'country_code': 'VI',
      'name': 'Virgin Islands (U.S.)',
      'dial_code': '+1340'
    },
    {'country_code': 'WF', 'name': 'Wallis and Futuna', 'dial_code': '+681'},
    {'country_code': 'YE', 'name': 'Yemen', 'dial_code': '+967'},
    {'country_code': 'ZM', 'name': 'Zambia', 'dial_code': '+260'},
    {
      'country_code': 'ZW',
      'name': 'Zimbabwe',
      'dial_code': '+263',
    }
  ];
}
