#Hotel Test Data......................................
valid_hotel_name = {
    'options':
        {
            "hotel_name": "Rose Rayhaan Rotana"
        }
}
invalid_hotel_name = {
    'options':
        {
            'hotel_name': 'dfasfasfsaf'
        }
}
valid_hotel_name_and_date = {
    'options':
        {
            'hotel_name': 'Rose Rayhaan Rotana',
            'start_date': '19/2/2022',
            'end_date': '10/10/2022'
        }
}
valid_hotel_name_and_date_and_persons = {
    'options':
        {
            'hotel_name': 'Rose Rayhaan Rotana',
            'start_date': '19/2/2022',
            'end_date': '10/10/2022',
            "adults": '2',
            "child": '5'
        }
}
#Flights Test Data......................................
search_flights_with_all_valid_fields = {
    'flight':
        {
            'cabinClass': 'First',
            'fromLocation': 'Ahmedabad',
            'toLocation': 'Delhi',
            'adult': '2',
            'child': '2',
            'infant': '0',
        }

}
search_flights_with_invalid_locations = {
    'flight':
        {
            'cabinClass': 'First',
            'fromLocation': 'Ahmedabad',
            'toLocation': 'Delhi',
            'adult': '2',
            'child': '2',
            'infant': '0',
        }

}
search_flights_with_only_valid_locations = {
    'flight':
        {
            'cabinClass': 'First',
            'fromLocation': 'Ahmedabad',
            'toLocation': 'Delhi',
            'adult': '2',
            'child': '2',
            'infant': '0',
        }
}
