filter_table_with_valid_partially_name = {
        'filter':
        {
            'name': 'Jam'
        },
        'verify_data':
        {
            'rowCount': '1'
        }
}
filter_table_with_valid_full_name = {
        'filter':
        {
            'name': 'Margret Marmajuke'
        },
        'verify_data':
        {
            'rowCount': '1'
        }
}
filter_table_with_invalid_name = {
        'filter':
        {
            'name': 'teststes'
        },
        'verify_data':
        {
            'rowCount': '0'
        }
}
filter_table_with_name_as_wildcardchars = {
        'filter':
        {
            'name': '@$dsfks'
        },
        'verify_data':
        {
            'rowCount': '0'
        }
}