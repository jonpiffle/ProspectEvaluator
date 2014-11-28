from models import *
from collections import defaultdict, Counter
import nltk
import math

players = session.query(Player).all()

nested_dict = {}
idf_dict = defaultdict(int)
for player in players:

    player_dict = defaultdict(int)
    for article in player.news:
        try:
            chunked = nltk.tree.Tree(article.chunked_body)
        except:
            continue

        def filter(tree):
            return (tree.node == "NP")

        for subtree in chunked.subtrees(filter):
            noun_phrase = " ".join([word_pos.split("/")[0] for word_pos in subtree.leaves()])
            player_dict[noun_phrase] += 1

    for word, freq in player_dict.items():
        idf_dict[word] += 1

    nested_dict[player.id] = player_dict

for player in players:
    tfidf_dict = {}
    player_dict = nested_dict[player.id]
    for word, count in player_dict.items():
        tf = count
        idf = math.log(len(players) / float((1 + idf_dict[word])))
        tfidf_dict[word] = tf * idf

    player.keywords = str(sorted(tfidf_dict.items(), key=lambda x: -x[1]))
    session.add(player)
    session.commit()
