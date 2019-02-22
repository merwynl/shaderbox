
#####################
# Dictionaries
#####################

"""
Dictionaries are similar to lists except that they use keys to point to specific values.
Dictionaries can also be stored/read from other more mutable formats like JSON.
Dictionary keys need to be unique.
"""

monthConversions = {
    'Jan': '一ヶ月',
    'Feb': '二ヶ月',
    'Mar': '三ヶ月',
    'Apr': '四ヶ月',
    'May': '五ヶ月',
    'Jun': '六ヶ月',
    'Jul': '七ヶ月',
    'Aug': '八ヶ月',
    'Sep': '九ヶ月',
    'Oct': '十ヶ月',
    'Nov': '十一ヶ月',
    'Dec': '十二ヶ月'
}

# Printing a specific dictionary key value
print(monthConversions['Mar'])

# Printing a specific dictionary key value using get function
# Get function can take in a default value
print(monthConversions.get('foo', 'Invalid key found!'))
