from models import *
from collections import defaultdict, Counter
import nltk
import math
import enchant

players = session.query(Player).all()    

for player in players:
    for article in player.news:
        if article.body == "" or article.body is None or article.chunked_body is not None:
            continue

        ascii_body = article.body.encode('ascii', 'ignore')
        tokens = nltk.word_tokenize(ascii_body)
        tokens = [t for t in tokens if d.check(t)]
        tagged_tokens = nltk.pos_tag(tokens)
        chunked = nltk.RegexpParser(grammar).parse(tagged_tokens)

        article.chunked_body = str(chunked)
        session.add(article)
        session.commit()
