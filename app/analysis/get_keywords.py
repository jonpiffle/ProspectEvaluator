from models import *
from collections import defaultdict, Counter
import nltk
import math
import enchant

players = session.query(Player).all()
grammar = "NP: {<JJ>*<NN>*}"
d = enchant.Dict("en_US")

nested_dict = {}
idf_dict = defaultdict(int)
for player in players:

    player_dict = defaultdict(int)
    for article in player.news:
        if article.body == "" or article.body is None:
            continue

        """
        ascii_body = article.body.encode('ascii', 'ignore')
        tokens = nltk.word_tokenize(ascii_body)
        tokens = [t for t in tokens if d.check(t)]
        tagged_tokens = nltk.pos_tag(tokens)
        chunked = nltk.RegexpParser(grammar).parse(tagged_tokens)

        article.chunked_body = str(chunked)
        session.add(article)
        session.commit()
        """

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

#total_dict = sum((Counter(dict(x)) for x in nested_dict.values()), Counter())

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
