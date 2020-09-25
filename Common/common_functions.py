# Import the datetime module
from datetime import datetime

def get_sorted_number(list):
    for iter_num in range(0, len(list)):
        for idx in range(iter_num+1, len(list)):
            val1 = int(list[iter_num])
            val2 = int(list[idx])
            if val1 > val2:
                temp = list[iter_num]
                list[iter_num] = list[idx]
                list[idx] = temp
    return list

def get_sorted_dates(list):
    list.sort(key=lambda date: datetime.strptime(date, '%d/%m/%Y'))
    return list
