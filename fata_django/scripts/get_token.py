import requests

url = 'http://127.0.0.1:8000/oauth/token/'
s = requests.Session()
var = {
    'grant_type':'authorization_code',
    'code':'lktQq4D5RbgrnvTXS0IiYdNYr1IU1q',
    'redirect_uri':'https://www.baidu.com/',
    'client_id':'uYBdLZiYcsPzlGmPY7oshuH3p1i0VpwMRqQRbJfk',
    'client_secret':'3VlJ7DLLnTEa8raIJMr44AnCg1F9gG1PqUZsFiIR1G2Yu6Il0lat4HBFbAApMITqVwBzS2tnVhm07kgmGboMHQB1SxzaXYGocBw4aB2sYHoTvccwK4PxaVH16UMi4rzN',
}
r = s.post(url=url, data=var)

print('sssss', r.text)