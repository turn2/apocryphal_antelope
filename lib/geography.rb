module Geography

  STATES = [
    ["Alabama","AL"],
    ["Alaska","AK"],
    ["Arizona","AZ"],
    ["Arkansas","AR"],
    ["California","CA"],
    ["Colorado","CO"],
    ["Connecticut","CT"],
    ["Delaware","DE"],
    ["District Of Columbia","DC"],
    ["Florida","FL"],
    ["Georgia","GA"],
    ["Hawaii","HI"],
    ["Idaho","ID"],
    ["Illinois","IL"],
    ["Indiana","IN"],
    ["Iowa","IA"],
    ["Kansas","KS"],
    ["Kentucky","KY"],
    ["Louisiana","LA"],
    ["Maine","ME"],
    ["Maryland","MD"],
    ["Massachusetts","MA"],
    ["Michigan","MI"],
    ["Minnesota","MN"],
    ["Mississippi","MS"],
    ["Missouri","MO"],
    ["Montana","MT"],
    ["Nebraska","NE"],
    ["Nevada","NV"],
    ["New Hampshire","NH"],
    ["New Jersey","NJ"],
    ["New Mexico","NM"],
    ["New York","NY"],
    ["North Carolina","NC"],
    ["North Dakota","ND"],
    ["Ohio","OH"],
    ["Oklahoma","OK"],
    ["Oregon","OR"],
    ["Pennsylvania","PA"],
    ["Rhode Island","RI"],
    ["South Carolina","SC"],
    ["South Dakota","SD"],
    ["Tennessee","TN"],
    ["Texas","TX"],
    ["Utah","UT"],
    ["Vermont","VT"],
    ["Virginia","VA"],
    ["Washington","WA"],
    ["West Virginia","WV"],
    ["Wisconsin","WI"],
    ["Wyoming","WY"]
  ]  

  PROVINCES = [

    ["Alberta", "AB"],
    ["British Columbia", "BC"],
    ["Manitoba", "MB"],
    ["New Brunswick", "NB"],
    ["Newfoundland and Labrador", "NL"],
    ["Northwest Territories", "NT"],
    ["Nova Scotia", "NS"],
    ["Nunavut", "NU"],
    ["Ontario", "ON"],
    ["Prince Edward Island", "PE"],
    ["Quebec", "QC"],
    ["Saskatchewan", "SK"],
    ["Yukon", "YT"]
  ]

  STATE_CODES = STATES.map { |s| s[1] }
  STATE_NAME_LOOKUP = STATES.inject({}) { |hsh, state| hsh[state[1]] = state[0]; hsh }
  STATE_CODE_LOOKUP = STATES.inject({}) { |hsh, state| hsh[state[0]] = state[1]; hsh }
  US_POSTAL_CODE_FORMAT = /^\d{5}$/

  PROVINCE_CODES = PROVINCES.map { |s| s[1] }
  PROVINCE_NAME_LOOKUP = PROVINCES.inject({}) { |hsh, state| hsh[state[1]] = state[0]; hsh }
  PROVINCE_CODE_LOOKUP = PROVINCES.inject({}) { |hsh, state| hsh[state[0]] = state[1]; hsh }
  CANADA_POSTAL_CODE_FORMAT = /^[ABCEGHJKLMNPRSTVXY]\d[A-Z] ?\d[A-Z]\d$/

  STATES_AND_PROVINCES = STATES + PROVINCES

  STATE_AND_PROVINCE_CODES = STATES_AND_PROVINCES.map { |s| s[1] }
  STATE_AND_PROVINCE_NAME_LOOKUP = STATES_AND_PROVINCES.inject({}) { |hsh, state| hsh[state[1]] = state[0]; hsh }
  STATE_AND_PROVINCE_CODE_LOOKUP = STATES_AND_PROVINCES.inject({}) { |hsh, state| hsh[state[0]] = state[1]; hsh }
  US_AND_CANADA_POSTAL_CODE_FORMAT = /(^\d{5}$)|(^[ABCEGHJKLMPRSTVXY]\d[A-Z] ?\d[A-Z]\d$)/

end
