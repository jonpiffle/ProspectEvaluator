from TwitterAPI import TwitterAPI
from datetime import datetime
from models import *

consumer_key        = "PiFfLSS52uCCLRat2GwOYo644"
consumer_secret     = "fwtyvxjv9hRJPGtzGCCPEVK7Owv4KR4PndXLSdkP4c5Z15V2FM"
access_token        = "90376572-diFf0pzeExiknrLVitXJVNGfKpl4NF1FSCQOrtZbw"
access_token_secret = "MFAao4cUUIPGVLz4IdY7F87xmNnetOHgYYbtkp2UgRWIp"

api = TwitterAPI(consumer_key, consumer_secret, access_token, access_token_secret)

players = session.query(Player).all()
for player in players:
    request_dict = {
        'screen_name': player.twitter_handle,
        'exclude_replies': True,
        'include_rts': False,
        'count': 100
    }
    r = api.request('statuses/user_timeline', request_dict)

    for tweet_dict in r.get_iterator():
        if 'text' not in tweet_dict:
            continue

        tweet = Tweet()
        tweet.player_id = player.id
        tweet.text = tweet_dict['text']
        tweet.tweet_id = tweet_dict['id']
        tweet.tweet_time = datetime.strptime(tweet_dict['created_at'], "%a %b %d %H:%M:%S +0000 %Y")
        session.add(tweet)
        try:
            session.commit()
        except:
            session.rollback()
            continue

    request_dict = {
        'q': player.name,
        'count': 100
    }
    r = api.request('search/tweets', request_dict)

    for tweet_dict in r.get_iterator():
        if 'text' not in tweet_dict:
            continue

        tweet = TweetAbout()
        tweet.player_id = player.id
        tweet.text = tweet_dict['text']
        tweet.tweet_id = tweet_dict['id']
        tweet.tweet_time = datetime.strptime(tweet_dict['created_at'], "%a %b %d %H:%M:%S +0000 %Y")
        tweet.tweeted_by = tweet_dict['user']['screen_name']
        session.add(tweet)
        try:
            session.commit()
        except:
            session.rollback()
            continue
