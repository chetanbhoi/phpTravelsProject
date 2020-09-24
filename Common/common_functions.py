# Import the datetime module
from datetime import datetime

def factorial(n):
    # single line to find factorial
    return 1 if (n == 1 or n == 0) else n * factorial(n - 1);


# num = 5;
# print("Factorial of",num,"is", factorial(num))

def get_sorted_number(list):
    for iter_num in range(len(list)-1,0,-1):
        for idx in range(iter_num):
            if list[idx]>list[idx+1]:
                temp = list[idx]
                list[idx] = list[idx+1]
                list[idx+1] = temp
    return  list

def get_sorted_dates(list):
    list.sort(key=lambda date: datetime.strptime(date, '%d/%m/%Y'))
    return  list

if __name__ == "__main__":
    list = [12,3,1900,23,2,1601,1,2,2020]

    # Sort the list in ascending order of dates
    # dates.sort(key=lambda date: datetime.strptime(date, '%d/%m/%Y'))

    get_sorted_number(list)
    print(list)