from sqlalchemy import Column, ForeignKey, Integer, String, Boolean, Float, Text, Date, UniqueConstraint
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, backref
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

class Player(Base):
    __tablename__ = 'players'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    position = Column(String)
    hometown = Column(String)
    college_class = Column(String)
    reach = Column(String)
    wingspan = Column(String)
    age = Column(String)
    date_of_birth = Column(String)
    college = Column(String)
    height = Column(String)
    weight = Column(String)
    photo_url = Column(String)
    espn_overall_rank = Column(String)
    espn_position_rank = Column(String)
    twitter_handle = Column(String)
    keywords = Column(Text)
    news = relationship("News")
    tweets = relationship("Tweet")
    tweet_abouts = relationship("TweetAbout")

    def __repr__(self):
        return "<Player: %s>" % (self.name)

class News(Base):
    __tablename__ = 'news'
    __table_args__ = (UniqueConstraint('url'), )

    id = Column(Integer, primary_key=True)
    player_id = Column(Integer, ForeignKey("players.id"))
    url = Column(String)
    title = Column(String)
    source = Column(String)
    description = Column(Text)
    date_posted = Column(Date)
    html = Column(Text)
    body = Column(Text)
    chunked_body = Column(Text)
    player = relationship("Player", foreign_keys="News.player_id")

    def __repr__(self):
        return "<News: %s>" % (self.title)

class Tweet(Base):
    __tablename__ = 'tweets'
    __table_args__ = (UniqueConstraint('tweet_id'), )

    id = Column(Integer, primary_key=True)
    text = Column(String)
    tweet_id = Column(String)
    tweet_time = Column(Date)
    player_id = Column(Integer, ForeignKey("players.id"))
    player = relationship("Player", foreign_keys="Tweet.player_id")

class TweetAbout(Base):
    __tablename__ = 'tweet_abouts'
    __table_args__ = (UniqueConstraint('tweet_id'), )

    id = Column(Integer, primary_key=True)
    text = Column(String)
    tweet_id = Column(String)
    tweet_time = Column(Date)
    tweeted_by = Column(String)
    player_id = Column(Integer, ForeignKey("players.id"))
    player = relationship("Player", foreign_keys="TweetAbout.player_id")


engine = create_engine('sqlite:///../../db/development.sqlite3')
connection = engine.connect()
Base.metadata.bind = engine
DBSession = sessionmaker(bind=engine)
session = DBSession()