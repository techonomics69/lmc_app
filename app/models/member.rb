class Member < ApplicationRecord
	has_one :membership
	has_one :emergency_contact
	before_save { build_membership }
	before_save { build_emergency_contact }

	before_save { email.downcase! }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :first_name, 	 presence: true
	validates :last_name,    presence: true
	validates :address_1,    presence: true, length: { maximum: 100 }
	validates :address_2,		 length: { maximum: 100 }
	validates :address_3,		 length: { maximum: 100 }
	validates :town,       	 presence: true, length: { maximum: 100 }
	validates :postcode,   	 presence: true, length: { maximum: 8 }
	validates :country,    	 presence: true
	validates :phone,	  		 length: { is: 11 }, numericality: true, allow_nil: true
	validates :email, 			 presence: true, length: { maximum: 255 },
													 format: { with: VALID_EMAIL_REGEX },
													 uniqueness: { case_sensitive: false }
	validates :dob,        	 presence: true
	validates :experience,   presence: true, length: { maximum: 500 }
	validates :accept_risks, inclusion: { in: [ true ] }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	PARTICIPATION_STATEMENT = "I accept that climbing and mountaineering are activities with a danger of personal injury or death. I am aware of and shall accept these risks and wish to participate in these activities voluntarily and shall be responsible for my own actions and involvement."
	
	COUNTRIES = [
		"United Kingdom",
	  "Afghanistan",
	  "Aland Islands",
	  "Albania",
	  "Algeria",
	  "American Samoa",
	  "Andorra",
	  "Angola",
	  "Anguilla",
	  "Antarctica",
	  "Antigua And Barbuda",
	  "Argentina",
	  "Armenia",
	  "Aruba",
	  "Australia",
	  "Austria",
	  "Azerbaijan",
	  "Bahamas",
	  "Bahrain",
	  "Bangladesh",
	  "Barbados",
	  "Belarus",
	  "Belgium",
	  "Belize",
	  "Benin",
	  "Bermuda",
	  "Bhutan",
	  "Bolivia",
	  "Bosnia and Herzegowina",
	  "Botswana",
	  "Bouvet Island",
	  "Brazil",
	  "British Indian Ocean Territory",
	  "Brunei Darussalam",
	  "Bulgaria",
	  "Burkina Faso",
	  "Burundi",
	  "Cambodia",
	  "Cameroon",
	  "Canada",
	  "Cape Verde",
	  "Cayman Islands",
	  "Central African Republic",
	  "Chad",
	  "Chile",
	  "China",
	  "Christmas Island",
	  "Cocos (Keeling) Islands",
	  "Colombia",
	  "Comoros",
	  "Congo",
	  "Congo, the Democratic Republic of the",
	  "Cook Islands",
	  "Costa Rica",
	  "Cote d'Ivoire",
	  "Croatia",
	  "Cuba",
	  "Cyprus",
	  "Czech Republic",
	  "Denmark",
	  "Djibouti",
	  "Dominica",
	  "Dominican Republic",
	  "Ecuador",
	  "Egypt",
	  "El Salvador",
	  "Equatorial Guinea",
	  "Eritrea",
	  "Estonia",
	  "Ethiopia",
	  "Falkland Islands (Malvinas)",
	  "Faroe Islands",
	  "Fiji",
	  "Finland",
	  "France",
	  "French Guiana",
	  "French Polynesia",
	  "French Southern Territories",
	  "Gabon",
	  "Gambia",
	  "Georgia",
	  "Germany",
	  "Ghana",
	  "Gibraltar",
	  "Greece",
	  "Greenland",
	  "Grenada",
	  "Guadeloupe",
	  "Guam",
	  "Guatemala",
	  "Guernsey",
	  "Guinea",
	  "Guinea-Bissau",
	  "Guyana",
	  "Haiti",
	  "Heard and McDonald Islands",
	  "Holy See (Vatican City State)",
	  "Honduras",
	  "Hong Kong",
	  "Hungary",
	  "Iceland",
	  "India",
	  "Indonesia",
	  "Iran, Islamic Republic of",
	  "Iraq",
	  "Ireland",
	  "Isle of Man",
	  "Israel",
	  "Italy",
	  "Jamaica",
	  "Japan",
	  "Jersey",
	  "Jordan",
	  "Kazakhstan",
	  "Kenya",
	  "Kiribati",
	  "Korea, Democratic People's Republic of",
	  "Korea, Republic of",
	  "Kuwait",
	  "Kyrgyzstan",
	  "Lao People's Democratic Republic",
	  "Latvia",
	  "Lebanon",
	  "Lesotho",
	  "Liberia",
	  "Libyan Arab Jamahiriya",
	  "Liechtenstein",
	  "Lithuania",
	  "Luxembourg",
	  "Macao",
	  "Macedonia, The Former Yugoslav Republic Of",
	  "Madagascar",
	  "Malawi",
	  "Malaysia",
	  "Maldives",
	  "Mali",
	  "Malta",
	  "Marshall Islands",
	  "Martinique",
	  "Mauritania",
	  "Mauritius",
	  "Mayotte",
	  "Mexico",
	  "Micronesia, Federated States of",
	  "Moldova, Republic of",
	  "Monaco",
	  "Mongolia",
	  "Montenegro",
	  "Montserrat",
	  "Morocco",
	  "Mozambique",
	  "Myanmar",
	  "Namibia",
	  "Nauru",
	  "Nepal",
	  "Netherlands",
	  "Netherlands Antilles",
	  "New Caledonia",
	  "New Zealand",
	  "Nicaragua",
	  "Niger",
	  "Nigeria",
	  "Niue",
	  "Norfolk Island",
	  "Northern Mariana Islands",
	  "Norway",
	  "Oman",
	  "Pakistan",
	  "Palau",
	  "Palestinian Territory, Occupied",
	  "Panama",
	  "Papua New Guinea",
	  "Paraguay",
	  "Peru",
	  "Philippines",
	  "Pitcairn",
	  "Poland",
	  "Portugal",
	  "Puerto Rico",
	  "Qatar",
	  "Reunion",
	  "Romania",
	  "Russian Federation",
	  "Rwanda",
	  "Saint Barthelemy",
	  "Saint Helena",
	  "Saint Kitts and Nevis",
	  "Saint Lucia",
	  "Saint Pierre and Miquelon",
	  "Saint Vincent and the Grenadines",
	  "Samoa",
	  "San Marino",
	  "Sao Tome and Principe",
	  "Saudi Arabia",
	  "Senegal",
	  "Serbia",
	  "Seychelles",
	  "Sierra Leone",
	  "Singapore",
	  "Slovakia",
	  "Slovenia",
	  "Solomon Islands",
	  "Somalia",
	  "South Africa",
	  "South Georgia and the South Sandwich Islands",
	  "Spain",
	  "Sri Lanka",
	  "Sudan",
	  "Suriname",
	  "Svalbard and Jan Mayen",
	  "Swaziland",
	  "Sweden",
	  "Switzerland",
	  "Syrian Arab Republic",
	  "Taiwan, Province of China",
	  "Tajikistan",
	  "Tanzania, United Republic of",
	  "Thailand",
	  "Timor-Leste",
	  "Togo",
	  "Tokelau",
	  "Tonga",
	  "Trinidad and Tobago",
	  "Tunisia",
	  "Turkey",
	  "Turkmenistan",
	  "Turks and Caicos Islands",
	  "Tuvalu",
	  "Uganda",
	  "Ukraine",
	  "United Arab Emirates",
	  
	  "United States",
	  "United States Minor Outlying Islands",
	  "Uruguay",
	  "Uzbekistan",
	  "Vanuatu",
	  "Venezuela",
	  "Vietnam",
	  "Virgin Islands, British",
	  "Virgin Islands, U.S.",
	  "Wallis and Futuna",
	  "Western Sahara",
	  "Yemen",
	  "Zambia",
	  "Zimbabwe"
	]
end