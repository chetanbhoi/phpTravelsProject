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
sort_table_by_name_field = {
        'sort':
        {
            'fieldName': 'name',
            'sortType': 'asc'
        }
}
sort_table_by_progress_field = {
        'sort':
        {
            'fieldName': 'progress',
            'sortType': 'asc'
        }
}
sort_table_by_gender_field = {
        'sort':
        {
            'fieldName': 'gender',
            'sortType': 'asc'
        }
}
sort_table_by_rating_field = {
        'sort':
        {
            'fieldName': 'rating',
            'sortType': 'asc'
        }
}
sort_table_by_color_field = {
        'sort':
        {
            'fieldName': 'col',
            'sortType': 'asc'
        }
}
sort_table_by_dob_field = {
        'sort':
        {
            'fieldName': 'dob',
            'sortType': 'asc'
        }
}
sort_table_by_driver_field = {
        'sort':
        {
            'fieldName': 'car',
            'sortType': 'asc'
        }
}