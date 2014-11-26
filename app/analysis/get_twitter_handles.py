from TwitterAPI import TwitterAPI
from models import *

consumer_key        = "PiFfLSS52uCCLRat2GwOYo644"
consumer_secret     = "fwtyvxjv9hRJPGtzGCCPEVK7Owv4KR4PndXLSdkP4c5Z15V2FM"
access_token        = "90376572-diFf0pzeExiknrLVitXJVNGfKpl4NF1FSCQOrtZbw"
access_token_secret = "MFAao4cUUIPGVLz4IdY7F87xmNnetOHgYYbtkp2UgRWIp"

api = TwitterAPI(consumer_key, consumer_secret, access_token, access_token_secret)

players = session.query(Player).all()

for player in players:
    request_dict = {'q': player.name, 'count': 1}
    r = api.request('users/search', request_dict)

    user_names = [user['screen_name'] for user in r.get_iterator()]

    user_name = ""
    if len(user_names) > 0:
        user_name = user_names[0]


    player.twitter_handle = user_name

session.commit()
