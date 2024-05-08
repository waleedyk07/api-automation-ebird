import random
import string

def generate_string(length):
    return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(length))

def generate_profile():
    return {
        "firstName": generate_string(10),
	"lastName": generate_string(10),
	"street": generate_string(10),
	"city": generate_string(10),
	"state": generate_string(2),
	"zipCode": generate_string(4),
	"phoneNumber": generate_string(10),
	"ssn": generate_string(10),
	"username": generate_string(10),
	"password": generate_string(10)
    }

def echo(name):
    return f'Hello - {name}'